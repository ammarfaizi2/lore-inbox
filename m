Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVCJCk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVCJCk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVCJChy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 21:37:54 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:61363 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261156AbVCJChK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:37:10 -0500
Message-ID: <422FB2B5.3070803@yahoo.com>
Date: Wed, 09 Mar 2005 18:36:37 -0800
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: Lars Marowsky-Bree <lmb@suse.de>
CC: Matt Mackall <mpm@selenic.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/6] Open-iSCSI High-Performance Initiator for Linux
References: <422BFCB2.6080309@yahoo.com> <20050309050434.GT3163@waste.org> <422E8EEB.7090209@yahoo.com> <20050309060544.GW3120@waste.org> <422E96D9.6090202@yahoo.com> <20050309222114.GF4105@marowsky-bree.de>
In-Reply-To: <20050309222114.GF4105@marowsky-bree.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:

>On 2005-03-08T22:25:29, Alex Aizman <itn780@yahoo.com> wrote:
>  
>
>>There's (or at least was up until today) an ongoing discussion on our 
>>mailing list at http://groups-beta.google.com/group/open-iscsi. The 
>>short and long of it: the problem can be solved, and it will. Couple 
>>simple things we already do: mlockall() to keep the daemon un-swapped, 
>>and also looking into potential dependency created by syslog (there's 
>>one for 2.4 kernel, not sure if this is an issue for 2.6).
>>    
>>
>
>BTW, to get around the very same issues, heartbeat does much the same:
>lock itself into memory, reserve a couple of pages more to spare on
>stack & heap, run at soft-realtime priority.
>  
>
Heartbeat is good for reliability, etc. WRT "getting paged-out" - 
non-deterministic (things depend on time), right?

>syslog(), however, sucks.
>  
>
It does.

>We went down the path of using our non-blocking IPC library to have all
>our various components log to ha_logd, which then logs to syslog() or
>writes to disk or wherever.
>  
>

Found ha_logd under http://linux-ha.org. The latter is extemely 
interesting in the longer term. In the short term, there's quite a bit 
of information on this site, need time.

>That works well in our current development series, and if you want to
>share code, you can either rip it off (Open Source, we love ya ;) or we
>can spin off these parts into a sub-package for you to depend on...
>
>  
>
If it's not a big deal :-) let's do the "sub-package" option.

>>The sfnet is a learning experience; it is by no means a proof that it 
>>cannot be done.
>>    
>>
>
>I'd also argue that it MUST be done, because the current way of "Oh,
>it's somehow related to block stuff, must be in kernel" leads down to
>hell. We better figure out good ways around it ;-)
>  
>
Yes, it MUST be done.

>
>Sincerely,
>    Lars Marowsky-Brée <lmb@suse.de>
>
>  
>
Alex
