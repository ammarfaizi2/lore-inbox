Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbSLaDzZ>; Mon, 30 Dec 2002 22:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267164AbSLaDzZ>; Mon, 30 Dec 2002 22:55:25 -0500
Received: from services.cam.org ([198.73.180.252]:1212 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267162AbSLaDzY> convert rfc822-to-8bit;
	Mon, 30 Dec 2002 22:55:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] fix o(1) handling of threads
Date: Mon, 30 Dec 2002 23:03:50 -0500
User-Agent: KMail/1.4.3
References: <20021230230030.AAA103@shell.webmaster.com@whenever>
In-Reply-To: <20021230230030.AAA103@shell.webmaster.com@whenever>
MIME-Version: 1.0
Message-Id: <200212302303.50119.tomlins@cam.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 30, 2002 06:00 pm, David Schwartz wrote:
> On Mon, 30 Dec 2002 16:45:50 -0500, Ed Tomlinson wrote:
> >What this patches does is recognise threads as process that clone both
> >mm and files.  For these 'threads' it tracks how many are active in a
> >given group.  When many are active it reduces their timeslices as below
>
> 	In general, changes that cause the system to become less efficient as load
> increases are not such a good idea. By reducing timeslices, you increase
> context-switching overhead. So the busier you are, the less efficient you
> get. I think it would be wiser to keep the timeslice the same but assign
> fewer timeslices.

That would be better - I cannot see a way to do it using O(1).  What might
be possible (not sure how) is only to decrease the timeslices IF there are
other tasks being slowed down by the thread group...

Ed

