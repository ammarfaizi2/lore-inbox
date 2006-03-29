Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWC2Xum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWC2Xum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWC2Xul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:50:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45735 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751288AbWC2Xuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:50:40 -0500
Date: Wed, 29 Mar 2006 15:50:31 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       Zoltan Menyhart <Zoltan.Menyhart@free.fr>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
In-Reply-To: <200603292348.k2TNmNg12952@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603291550050.26228@schroedinger.engr.sgi.com>
References: <200603292348.k2TNmNg12952@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006, Chen, Kenneth W wrote:

> Is gcc smart enough to turn constant argument and collapse inline of
> inline function?  I hope it does.

Sure we use that all the time. Look at the cmpxchg definition in 
asm-ia64/system.h
