Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWAXMBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWAXMBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 07:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWAXMBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 07:01:22 -0500
Received: from mail.customers.edis.at ([62.99.242.131]:49891 "EHLO
	smtp-1.edis.at") by vger.kernel.org with ESMTP id S1030434AbWAXMBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 07:01:21 -0500
Message-ID: <43D61712.9080300@lawatsch.at>
Date: Tue, 24 Jan 2006 13:01:22 +0100
From: Philip Lawatsch <philip@lawatsch.at>
Organization: WaUG HQ Graz
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8) Gecko/20060114 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Philip Lawatsch <philip@lawatsch.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFSv3 / VFS and group problems
References: <43D55DC3.9080900@lawatsch.at>
In-Reply-To: <43D55DC3.9080900@lawatsch.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Lawatsch wrote:
> Hi,
> 
> I've had the joy to debug a production system with a really crappy setup.
> 
> They have a user "fred" which belongs to ~5000 groups (say 
> group1-group5000).
> 
> 
> So far so bad. Even worse, they have a nfs backend  with lots of files 
> which are owned by users belonging to these groups.
> 
> Ok, now my problem is that "fred" can open a file which is
> 
> -rw-rw----  someone group300 foo
> 
> but a read on this file will fail with EIO
> 
> Since group300 is way beyond the 16 groups nfs supports shouldn't fred 
> actually get a EACCES back from the open call?
> 
> Problem happens with 2.6.13 (vanilla, not tainted) on both server and 
> client.

Just tried it between two 2.6.15.1 machines. It works as expected there. 
Seems that the client actually screwed around with the machines more 
than he was willing to admit. Sorry for the noise.

kind regards Philip
