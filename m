Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265163AbUGDQPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUGDQPg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 12:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbUGDQPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 12:15:36 -0400
Received: from holomorphy.com ([207.189.100.168]:18634 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265163AbUGDQPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 12:15:35 -0400
Date: Sun, 4 Jul 2004 09:15:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com
Subject: Re: move O_LARGEFILE forcing to filp_open()
Message-ID: <20040704161530.GF21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, hugh@veritas.com
References: <20040704064122.GY21066@holomorphy.com> <200407041422.57614.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407041422.57614.arnd@arndb.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 4. Juli 2004 08:41, William Lee Irwin III wrote:
>>                        sys_open() in turn calls filp_open(). So merely
>> moving the forcing of the flag on 64-bit resolves this situation there,
>> though not for 32-bit, whose solution is to appear in the sequel.

On Sun, Jul 04, 2004 at 02:22:56PM +0200, Arnd Bergmann wrote:
> Unfortunately, this will also cause problems for 32-bit emulation, where
> sys32_open currently calls filp_open without forcing O_LARGEFILE for
> 32 bit applications.
> I also noticed that this behavior currently is not implemented on all
> architectures, which in turn would need the patch below.
> Maybe you can find a way to fix both problems.

Your patch is also necessary; thanks for covering these cases.


-- wli
