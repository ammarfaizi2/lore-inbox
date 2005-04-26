Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVDZRKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVDZRKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVDZRKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:10:39 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:35765 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261657AbVDZRKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:10:31 -0400
In-Reply-To: <Pine.LNX.4.58.0504261347110.4555@be1.lrz>
To: Bodo Eggert <7eggert@gmx.de>
Cc: 7eggert@gmx.de, akpm@osdl.org, Jan Hudec <bulb@ucw.cz>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk
MIME-Version: 1.0
Subject: Re: [PATCH] private mounts
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF7E89A8B8.2AC04C42-ON88256FEF.005DACE1-88256FEF.005E7421@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Tue, 26 Apr 2005 10:10:22 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/26/2005 13:10:29,
	Serialize complete at 04/26/2005 13:10:29
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >mknamespace -p users/$UID # (like mkdir -p)
>> >setnamespace users/$UID   # (like cd)
>>                               ^^^^^^^^
>> 
>> You realize that 'cd' is a shell command, and has to be, I hope.  That 
>> little fact has thrown a wrench into many of the ideas in this thread.
>
>I suppose it will be called by the login process or by wrappers like 
>'nice'.

Just to be clear, then: this idea is fundamentally different from the 
mkdir/cd analogy the thread starts with above.  And it misses one rather 
important requirement compared to mkdir/cd:  You can't add a new mount to 
an existing shell.

Several more complicated schemes that may achieve that are being discussed 
in this thread.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems

