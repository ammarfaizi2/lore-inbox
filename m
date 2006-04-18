Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWDRNQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWDRNQy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWDRNQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:16:54 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:64962 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750742AbWDRNQx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:16:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d5/O2QV51aGLyxsVsYJ56YjxTy2TLGqVUBr/cmc38R1+jNdocXtSKMr2P5+uU4tImOxaYJwAHItTGIW25y9JjNELeC6IsG82E92cIs5sH524OGQyEgHq41m7SX59zQOXnkftFB2gvkAxBz/yeN7AlpOASdJELOBhBa5Gm8JBK0A=
Message-ID: <35fb2e590604180616r33a05380p65c0e1c26ae276de@mail.gmail.com>
Date: Tue, 18 Apr 2006 14:16:53 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] binary firmware and modules
In-Reply-To: <1145088656.23134.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145088656.23134.54.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/06, Jon Masters <jcm@redhat.com> wrote:

> The attached patch introduces MODULE_FIRMWARE as one way of advertising
> that a particular firmware file is to be loaded - it will then show up
> via modinfo and could be used e.g. when packaging a kernel. I've also
> given an example via the QLogic gla2xxx driver.

Ok. If nobody shouts today I'm going to suggest this go into 2.6.17. I
think more ellaborate schemes will come up later, but we also need
something usable out there now.

As others have pointed out, cunning schemes to hack how
request_firmware et al work are all very well and good, but often we
just don't know what firmware we'll need until runtime. Unless or
until there's a good way to address that, I think modules will need to
advertise every firmware and distros will have to package all possible
firmwares, just in case.

Jon.
