Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVEPRmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVEPRmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVEPRkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:40:36 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:64427 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261506AbVEPRi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:38:58 -0400
Date: Mon, 16 May 2005 12:33:06 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: improve output in sysfs files when the TPM fails
In-Reply-To: <20050513223003.4f9dc539.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505161230240.6712@localhost.localdomain>
References: <Pine.LNX.4.62.0505121717240.11837@localhost.localdomain>
 <20050512225541.GA29958@kroah.com> <Pine.LNX.4.62.0505131422350.13489@localhost.localdomain>
 <20050513223003.4f9dc539.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005, Andrew Morton wrote:

> Kylene Hall <kjhall@us.ibm.com> wrote:
> >
> >  On Thu, 12 May 2005, Greg KH wrote:
> >  > On Thu, May 12, 2005 at 05:20:22PM -0500, Kylene Hall wrote:
> >  > > When the TPM is in a disabled or deactivated state the sysfs pcrs and 
> >  > > pubek files will appear empty.  To remove any confusion this might cause, 
> >  > > the files will instead contain the error the TPM returned (also indicative 
> >  > > of what state the TPM is in and what actions might be needed to change 
> >  > > that state).
> >  > 
> >  > No, sysfs files are not error logs.  Please use the standard system wide
> >  > error log for this (syslog).
> >  > 
> >  > Why not just change the mode of the sysfs file instead, or delete it
> >  > entirely in this case?
> > 
> >  Ok, instead of putting error information in the sysfs file this new patch 
> >  will put an error entry in syslog.  The sysfs files can't easily be 
> >  removed in these cases as the driver does not know this information and it 
> >  can be changed by commands sent to the TPM from userspace.
> 
> Will this change permit unprivileged users to create large amounts of
> syslog output?  If so, this is considered poor form.
> 
> IOW: please confirm that the relevant sysfs files are root-read-only?
> 
> 

Please back this patch out since it is undesirable to use the sysfs 
file or syslog for the error reporting for various reasons and is 
desirable to keep the files not root-read-only.  The status of the TPM can 
be gleaned from other sources.

Thanks,
Kylie  
