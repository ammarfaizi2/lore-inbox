Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbUCXBdP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 20:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbUCXBdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 20:33:15 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:38584
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262935AbUCXBdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 20:33:14 -0500
Message-ID: <4060E24C.9000507@redhat.com>
Date: Tue, 23 Mar 2004 17:20:12 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
References: <20040323231256.GP4677@tpkurt.garloff.de>	<20040323154937.1f0dc500.akpm@osdl.org>	<20040324002149.GT4677@tpkurt.garloff.de> <16480.55450.730214.175997@napali.hpl.hp.com>
In-Reply-To: <16480.55450.730214.175997@napali.hpl.hp.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:

> I guess I never quiet understood why an entire program header is
> needed for this, but that's just me.

This just means you haven't looked at the problem.

First, the ELF bits are limited and very crowded on some archs.  There
is no central assignment so conflicts will happen.

And one single bit does not cut it.  If you'd take a look, the
PT_GNU_STACK entry's permissions field specifies what permissions the
stack must have, not the presence of the field.  So at least two bits
are needed which only adds to the problems of finding appropriate bits.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
