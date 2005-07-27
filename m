Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVG0TpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVG0TpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVG0TjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:39:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14499 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262446AbVG0The (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:37:34 -0400
Date: Wed, 27 Jul 2005 15:37:25 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: serue@us.ibm.com
cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [patch 0/15] lsm stacking v0.3: intro
In-Reply-To: <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com>
Message-ID: <Lynx.SEL.4.62.0507271535150.1844@thoron.boston.redhat.com>
References: <20050727181732.GA22483@serge.austin.ibm.com>
 <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005, James Morris wrote:

> Calls to security_get_value() etc. can then be very fast and simple for 
> the common case, where the security blob is a pointer offset by an index 
> in a small array.  The arbitrarily sized hlist would then be a fallback 
> with a higher performance hit.

Also, the static slots could be single-use only, so once a module 
registers for one, it's permanently assigned (even if the module unloads), 
to avoid locking overhead.  Module registration can just be test & set a 
bitmap.


- James
-- 
James Morris
<jmorris@redhat.com>

