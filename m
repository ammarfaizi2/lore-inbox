Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbUCJAfa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 19:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUCJAfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 19:35:30 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:60366
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262463AbUCJAfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 19:35:24 -0500
Message-ID: <404E62B4.4000200@redhat.com>
Date: Tue, 09 Mar 2004 16:35:00 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040309
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ppc/ppc64 and x86 vsyscalls
References: <1078708647.5698.196.camel@gaston> <404D7AC3.9050207@redhat.com>	 <1078830318.9746.3.camel@gaston>  <404E33A7.6070800@redhat.com> <1078867992.9745.25.camel@gaston>
In-Reply-To: <1078867992.9745.25.camel@gaston>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> /* In one place the actual function implementation */
>  function_A_vers_1()
>  function_A_vers_2()
>  function_A_vers_3()
>  function_B_vers_1()
>  function_B_vers_2()
>    etc .../...
> 
> /* Then, some empty "stubs" for the symbol table that gets really
>  * linked into user binaries. Those are the symbol table entries
>  * that get patched
>  */
>  function_A() {}
>  function_B() {}
> 
> Sounds right ?

Basically yes.  But you don't actually need the stub functions.  You
just need a symbol table entry which can be arranged via an alias to any
one of the real functions.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
