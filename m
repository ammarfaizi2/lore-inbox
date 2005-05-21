Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVEUAlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVEUAlT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 20:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVEUAlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 20:41:19 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:26805 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261622AbVEUAlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 20:41:13 -0400
In-Reply-To: <20050520231312.GD29155@mail.shareable.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>
MIME-Version: 1.0
Subject: Re: [PATCH] FUSE: don't allow restarting of system calls
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF220824D5.86601CDE-ON88257008.0003590B-88257008.0003D5B4@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 20 May 2005 17:41:21 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_04122005|April 12, 2005) at
 05/20/2005 20:41:11,
	Serialize complete at 05/20/2005 20:41:11
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Having a program be stuck in read/write ignoring signals, so that
>Control-C, Control-Z and kill don't work on it, while it's waiting for
>some network operation, is a horrible thing.

I've made it a personal crusade to eliminate D state.  In addition to all 
the damage done by computer resources being locked up, something about my 
computer ignoring me rankles me on a personal level.

I believe this proposal is about making open() hang, which I think is even 
more painful than having read/write hang.  open() is often designed to 
block much more casually.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
