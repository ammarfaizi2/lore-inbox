Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267460AbUGNQ5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUGNQ5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267458AbUGNQ5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:57:33 -0400
Received: from eis-msg-012.jpl.nasa.gov ([137.78.160.40]:9433 "EHLO
	eis-msg-012.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id S267460AbUGNQ5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:57:31 -0400
Message-ID: <40F565F3.3080103@jpl.nasa.gov>
Date: Wed, 14 Jul 2004 09:57:23 -0700
From: Roy Butler <roy.butler@jpl.nasa.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Chris Wedgwood <cw@f00f.org>
Subject: Re: kconfig's file handling
References: <40F4D266.4050006@jpl.nasa.gov> <20040714064400.GA9721@taniwha.stupidest.org>
In-Reply-To: <20040714064400.GA9721@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

Chris Wedgwood wrote:
> On Tue, Jul 13, 2004 at 11:27:50PM -0700, Roy Butler wrote:
> 
> 
>>By example, if you create a file, write to it, and then delete it
>>fast enough, it will never hit the disk under XFS.
> 
> 
> Nor will it under some other filesystems...  and in the above scenario
> I'm not sure that matters, why must a temporary file hit the disk at
> all?
> 
> 
>    --cw
> 

Suppose you want to do something with the file's contents before you 
delete it, but the system goes down before you have the chance.  Wasn't 
that the impetus for this thread?  With XFS, the potential for data loss 
is greater; that was my point.  I believe that everyone who pays extra 
for batter-backed I/O caches would agree. :)  Sure, different 
filesystems have their options, but this liability is ingrained in XFS.


Roy
