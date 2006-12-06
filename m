Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936661AbWLFRAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936661AbWLFRAf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936866AbWLFRAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:00:35 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:46290 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S936802AbWLFRAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:00:33 -0500
X-YMail-OSG: 4gqQleUVM1kTNA8IiJZctp5IVs53Cqhg9V4MTuVvE98eO9ggGw0K3vODIiB1a_3WxBE9rcWhc1pyaeU7VBwTQpNUUhnnTCQLeKZeKkmFmlBKREYYh6B07nJLuKeEH9qiIfwjKKgtsMmcnL4-
Date: Wed, 6 Dec 2006 09:00:30 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: gcc@gcc.gnu.org, GNU C Library <libc-alpha@sources.redhat.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Change x86 prefix order
Message-ID: <20061206170030.GA543@lucon.org>
References: <20061206070014.GA535@lucon.org> <20061206084317.4c0ef28d.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206084317.4c0ef28d.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 08:43:17AM -0800, Randy Dunlap wrote:
> On Tue, 5 Dec 2006 23:00:14 -0800 H. J. Lu wrote:
> 
> > On x86, the order of prefix SEG_PREFIX, ADDR_PREFIX, DATA_PREFIX and
> > LOCKREP_PREFIX isn't fixed. Currently, gas generates
> > 
> > LOCKREP_PREFIX ADDR_PREFIX DATA_PREFIX SEG_PREFIX
> > 
> > I will check in a patch:
> > 
> > http://sourceware.org/ml/binutils/2006-12/msg00054.html
> > 
> > tomorrow and change gas to generate
> > 
> > SEG_PREFIX ADDR_PREFIX DATA_PREFIX LOCKREP_PREFIX
> 
> Hi,
> Could you provide a "why" for this in addition to the
> "what", please?

LOCKREP_PREFIX is also used as SIMD prefix. DATA_PREFIX can be used as
either SIMD prefix or data size prefix for SIMD instructions. The new
order

SEG_PREFIX ADDR_PREFIX DATA_PREFIX LOCKREP_PREFIX

will make SIMD prefixes close to SIMD opcode.


H.J.
