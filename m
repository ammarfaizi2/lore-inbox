Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290346AbSAPEU0>; Tue, 15 Jan 2002 23:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289858AbSAPEUG>; Tue, 15 Jan 2002 23:20:06 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:41228 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S289854AbSAPET5>; Tue, 15 Jan 2002 23:19:57 -0500
Date: Tue, 15 Jan 2002 20:19:55 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local>
Message-ID: <Pine.LNX.4.33.0201152009030.12670-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0201152009032.12670@twinlark.arctic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 2002, Olaf Dietsche wrote:

> For example, you can say, user www is allowed to bind to port 80 or
> user mail is allowed to bind to port 25. Then, you can run apache as
> user www and sendmail as user mail. Now, you don't have to rely on
> apache or sendmail giving up superuser rights to enhance security.

typically logging must also occur as some other user than what the daemon
runs as, or else your logs are suspect in any sort of break-in.  this is
no problem for stuff using syslog, but since that's not the default
configuration for apache you might want to put a note in any docs you end
up including.  one suggestion is piped logging through a setuid logger
(setuid to user wwwlogs or something, root not required).

-dean


