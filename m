Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbUBZENa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 23:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbUBZEN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 23:13:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39114 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262661AbUBZENY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 23:13:24 -0500
Date: Wed, 25 Feb 2004 23:13:39 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Christophe Saout <christophe@saout.de>
cc: Andrew Morton <akpm@osdl.org>, <jlcooke@certainkey.com>,
       <linux-kernel@vger.kernel.org>, "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [PATCH 2/2] fix in-place de/encryption bug with highmem
In-Reply-To: <20040225225552.GB6536@leto.cs.pocnet.net>
Message-ID: <Xine.LNX.4.44.0402252311030.4922-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Christophe Saout wrote:

> This patch fixes the bug where in-place encryption was not detected
> when the same highmem pages is mapped twice to different virtual
> addresses.
> 
> This adds a parameter to xxx_process to indicate whether this is an
> in-place encryption and moves the responsability to the caller using
> a helper function scatterwalk.h.

These patches look good (now in -mm4), thanks for doing this.

Have you verified that the data corruption bug you saw has been fixed?
(Just in case there's more to it).


- James
-- 
James Morris
<jmorris@redhat.com>

