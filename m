Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTFSXON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTFSXOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:14:12 -0400
Received: from fe7.rdc-kc.rr.com ([24.94.162.160]:62215 "EHLO mail7.kc.rr.com")
	by vger.kernel.org with ESMTP id S261845AbTFSXOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:14:12 -0400
Date: Thu, 19 Jun 2003 18:27:49 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Solarz-Niesluchowski 
	<B.Solarz-Niesluchowski@wsisiz.edu.pl>
Subject: Re: 2.5.72 oops (scheduling while atomic)
Message-ID: <20030619232749.GA1503@glitch.localdomain>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org,
	Bartlomiej Solarz-Niesluchowski <B.Solarz-Niesluchowski@wsisiz.edu.pl>
References: <20030617143551.GA3057@glitch.localdomain> <20030618224656.0f5639bb.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618224656.0f5639bb.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 10:46:56PM -0700, Andrew Morton wrote:
> This appears to be because you haven't selected any chip drivers in IDE
> config.  I selected PIIX and things started working better.

Sure enough, Iafterenabling PIIX support I was able to boot successfully. 
I had left it out because my understanding was that it doesn't support
my chipset... this was incorrect, at least in the case of 2.5.x.  Also,
my 2.4.21 kernel was perfectly happy with PIIX disabled.

> Your .config seems broken in other ways btw.  Suggest you do 
> 
> 	cp arch/i386/defconfig .config
> 
> and start again.

Could you provide any specifics, or point me to some information on the
requirements?  My approach was to start with a working 2.4.x config,
and enable everything which appeared to be necessary.

Thanx!
