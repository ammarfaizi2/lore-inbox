Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264972AbUELFBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264972AbUELFBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 01:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264975AbUELFBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 01:01:03 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:52361
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S264971AbUELFA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 01:00:56 -0400
Message-ID: <40A1AF53.3010407@redhat.com>
Date: Tue, 11 May 2004 22:00:03 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: fastboot@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] kexec for linux 2.6.6
References: <20040511212625.28ac33ef.rddunlap@osdl.org>
In-Reply-To: <20040511212625.28ac33ef.rddunlap@osdl.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> And if anyone has suggestions for handling a variable/moving
> syscall number (target), I'm interested in hearing them.

If all architectures would finally get a vdso implementation you could
just add the necessary stub in the vdso, add a symbol in the symbol
table of the vdso, and use in the userlevel code

  sym = dlsym (RTLD_DEFAULT, "the_symbol_name")

If the returned value is not NULL the symbol exists.

I've described this many times as one of the huge advantages of vdsos,
hopefully this time it clicks.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
