Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbULHVic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbULHVic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbULHVic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:38:32 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7614 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261368AbULHVi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:38:29 -0500
Subject: RE: Figuring out physical memory regions from a kernel module
From: Dave Hansen <haveblue@us.ibm.com>
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C20596063B@azsmsx406>
References: <C863B68032DED14E8EBA9F71EB8FE4C20596063B@azsmsx406>
Content-Type: text/plain
Message-Id: <1102541907.883.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Dec 2004 13:38:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 13:26, Hanson, Jonathan M wrote:
> [Jon M. Hanson] Even looking at the implementation of the crashdump
> code, I still encounter the same problem I've run into up until now: the
> crashdump code is a part of the kernel so it has access to all of the
> kernel's data structures and functions; as a kernel module, I'm
> hamstrung by what is exported by the kernel. I know that I can modify
> the kernel to export whatever I want but I don't want to have to do
> that. I want to be able to run my kernel module without having to patch
> the kernel itself.

There's some design effort not to expose kernel *internals* to modules. 
Seems like your module requirements are different from the current
design direction of the kernel.

-- Dave

