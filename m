Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266774AbSL3WwK>; Mon, 30 Dec 2002 17:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266650AbSL3WwJ>; Mon, 30 Dec 2002 17:52:09 -0500
Received: from mail.webmaster.com ([216.152.64.131]:46792 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S266042AbSL3WwJ> convert rfc822-to-8bit; Mon, 30 Dec 2002 17:52:09 -0500
From: David Schwartz <davids@webmaster.com>
To: <tomlins@cam.org>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Mon, 30 Dec 2002 15:00:29 -0800
In-Reply-To: <200212301645.50278.tomlins@cam.org>
Subject: Re: [PATCH,RFC] fix o(1) handling of threads
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20021230230030.AAA103@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Dec 2002 16:45:50 -0500, Ed Tomlinson wrote:

>What this patches does is recognise threads as process that clone both
>mm and files.  For these 'threads' it tracks how many are active in a
>given group.  When many are active it reduces their timeslices as below

	In general, changes that cause the system to become less efficient as load 
increases are not such a good idea. By reducing timeslices, you increase 
context-switching overhead. So the busier you are, the less efficient you 
get. I think it would be wiser to keep the timeslice the same but assign 
fewer timeslices.

	DS


