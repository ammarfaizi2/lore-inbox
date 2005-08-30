Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVH3Pz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVH3Pz5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVH3Pz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:55:57 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:33863 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932186AbVH3Pz4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:55:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SkjTkBw6f6PAwQpFR1aBTnnXnlQ1fWoY4B4xsxMu5RGLZl0dOL2IOzrlE9kt1uN+uSRWSwyDgUMl/RfJUN6M+thQc1pKMyaPDbLD6xsBgitrcMqeHB79xInRR9zUnZSosuqc4QXu/ZtbrIihzPzurGGqHkGg0kdqKjKzbug5Lyo=
Message-ID: <599f06db0508300855653289f2@mail.gmail.com>
Date: Tue, 30 Aug 2005 10:55:53 -0500
From: Gorka guardiola <paurea@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Not able to see the symbols
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am programming a service in the kernel and want a module to be able to
use it. This means the module (an external module) need to see the symbols of
the variables (more specifically a lock and a list and some integers). 
The problem is the when I compile
the kernel the symbols are not exported. I run nm or look at the System.map and
they are not there, so the module doesnt see them and says "symbol undefined"
when trying to link. Suprisingly, for some reason, it doesnt complain
about the lock.

I tried including (in the kernel service, and even though it is not a
module) module.h and using the EXPORT_SYMBOL macro to no avail.


I have also tried compiling the module two different ways (in the hope
that it would see the symbols even if I dont)

make -C /lib/modules/_kernelname_/build module SUBDIRS=$(pwd)

and

make -C /lib/modules/_kernelname_/build M=$(pwd)

where _kernelname_ is the name of my kernel.

Please, CC me on any answers, as I am not on the list.

TIA,

G.-
