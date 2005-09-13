Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbVIMMPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbVIMMPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbVIMMPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:15:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:25519 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932625AbVIMMPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:15:50 -0400
Date: Tue, 13 Sep 2005 03:56:43 -0500
From: serue@us.ibm.com
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, serue@us.ibm.com,
       linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, James Bottomley <James.Bottomley@steeleye.com>,
       Dave C Boutcher <sleddog@us.ibm.com>
Subject: Re: ibmvscsi badness (Re: 2.6.13-mm3)
Message-ID: <20050913085643.GA24156@sergelap.austin.ibm.com>
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912222437.GA13124@sergelap.austin.ibm.com> <20050912161013.76ef833f.akpm@osdl.org> <20050913013840.GG5382@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913013840.GG5382@krispykreme>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anton Blanchard (anton@samba.org):
>  
> Hi,
> 
> > > With -mm2, I only get things like:
> > > 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> > > 	sda: Current: sense key: Aborted Command
> > > 	    Additional sense: No additional sense information
> > > 	Info fld=0x0
> > > 	end_request: I/O error, dev sda, sector 10468770
> > > 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> > > 	sda: Current: sense key: Aborted Command
> > > 	    Additional sense: No additional sense information
> > > 	Info fld=0x0
> > > 	end_request: I/O error, dev sda, sector 10468778
> > > 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> > > 	sda: Current: sense key: Aborted Command
> > > 	    Additional sense: No additional sense information
> > > 	Info fld=0x0
> > > 	end_request: I/O error, dev sda, sector 10468786
> > > 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> > > 	sda: Current: sense key: Aborted Command
> > > 	    Additional sense: No additional sense information
> > > 	Info fld=0x0
> > > 	end_request: I/O error, dev sda, sector 10468794
> 
> What virtual scsi server are you using?

The vioserver is running SLES9 (2.6.5-7.97-pseries64 kernel).

Lots of other people have partitions on this thing, so
upgrading the vioserver is a delicate operations.  A module
parameter would definately be preferable, at least short
term.

thanks,
-serge
