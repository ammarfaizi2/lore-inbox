Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVAUPQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVAUPQC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 10:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVAUPQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 10:16:02 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:64485 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262386AbVAUPPu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 10:15:50 -0500
Message-ID: <41F11CBD.1030105@watson.ibm.com>
Date: Fri, 21 Jan 2005 10:16:13 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
CC: Peter Williams <pwil3058@bigpond.net.au>,
       lkml <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] RE: [ANNOUNCE][RFC] plugsched-2.0 patches ...
References: <NIBBJLJFDHPDIBEEKKLPMEODDHAA.mef@cs.princeton.edu>
In-Reply-To: <NIBBJLJFDHPDIBEEKKLPMEODDHAA.mef@cs.princeton.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc E. Fiuczynski wrote:
> Hi Peter,
> 
> 
>>I'm hoping that the CKRM folks will send me a patch to add their
>>scheduler to plugsched :-)
> 
> 
> They are planning to release a patch against 2.6.10.  But their patch wont
> stand alone against 2.6.10 and so it might be difficult for you to integrate
> their code into a scheduler for plugsched.

Thats true. The current CKRM CPU scheduler is not a standalone 
component...if it were made one, it would need a non-CKRM interface to 
define classes, set their shares etc.

However, we have not investigated the possibility of making our CPU 
scheduler a pluggable one that could be loaded into a kernel equipped 
with the plugsched patches AND the CKRM framework. This should be 
possible but not a high priority until there is more  consensus for 
having CPU schedulers pluggable at all  (we have more basic stuff to fix 
in our scheduler such as load balancing).

Of course, we're more than happpy to work with someone willing to chip 
in and make our scheduler pluggable.

-- Shailabh

> Also, the CKRM scheduler only modifies Ingo's O(1) scheduler.  It certainly
> would be interesting to have CKRM variants of the other schedulers.  This
> points to a whole new level of 'plugsched' in that general O(1) schedulers
> need to support fair share plugins.
> 
> Marc
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
> 

