Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSKNMcs>; Thu, 14 Nov 2002 07:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSKNMcs>; Thu, 14 Nov 2002 07:32:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31496 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264886AbSKNMcr>;
	Thu, 14 Nov 2002 07:32:47 -0500
Date: Thu, 14 Nov 2002 12:39:40 +0000
From: Matthew Wilcox <willy@debian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module parameters reimplementation 0/4
Message-ID: <20021114123940.U30392@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> Jgarzik wrote:
> > Let's be more friendly to the namespace and call it something less
> > ambiguous, like MODULE_PARAM, even if that might not be strictly true in
> > 1% of the cases. IMO there are certainly valid local uses of 'PARAM' in
> > kernel code.
> 
> I disagree. It's a param, subsuming both __setup and MODULE_PARAM.
> The fact that it is implemented for modules is not something for the
> driver author to be concerned about (finally).

You're both wrong ;-)  `module' != `loadable module'.  module_init()
means `this is where you initialise this module', whether it's built-in
or synamically loaded.  MODULE_PARAM() should mean `this is a parameter
for this module', whether it's built-in or dynamically loaded.

-- 
Revolutions do not require corporate support.
