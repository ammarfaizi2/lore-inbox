Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWFTPE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWFTPE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWFTPE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:04:27 -0400
Received: from gw.openss7.com ([142.179.199.224]:59807 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1751293AbWFTPE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:04:26 -0400
Date: Tue, 20 Jun 2006 09:04:25 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Steven Whitehouse <steve@chygwyn.com>, Theodore Tso <tytso@thunk.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with inode.i_private
Message-ID: <20060620090425.C10897@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Steven Whitehouse <steve@chygwyn.com>,
	Theodore Tso <tytso@thunk.org>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <200606201345.45332.arnd.bergmann@de.ibm.com> <1150806849.3856.1370.camel@quoit.chygwyn.com> <200606201553.23908.arnd.bergmann@de.ibm.com> <20060620090135.B10897@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060620090135.B10897@openss7.org>; from bidulock@openss7.org on Tue, Jun 20, 2006 at 09:01:35AM -0600
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,

On Tue, 20 Jun 2006, Brian F. G. Bidulock wrote:
> 
> Placing i_private and i_pipe in the same union will break FIFOs.
> 
> Also, i_pipe should not be combined with i_cdev and i_bdev.
> 

Also, both character and block devices need separate use of i_private.
