Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbUKNSmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUKNSmI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 13:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbUKNSmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 13:42:08 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:1123 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261330AbUKNSmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 13:42:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=jcY88gABK2QowHOCka4bhYbpvR0uZ9Z4Tdf7aBtMLn+ggG3EJ1iSuR4Ji2l+tyWLuWOShQcgZj3ScSXh4psh7dM95sz6iOSk+UJT7xp1y5+Sw5f8rzp2kPvKCNs1ObVCFlwS+Ortp0oP8QNV0BRMCQcWFkv1AAcWYWZbgXJAhX0=
Message-ID: <64b1faec04111410421d76b8fa@mail.gmail.com>
Date: Sun, 14 Nov 2004 19:42:06 +0100
From: Sylvain <autofr@gmail.com>
Reply-To: Sylvain <autofr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: question about module and undeinfed symbols.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem of undefined symbol, that prevents me from loading
the module I wrote.

The function that is "undifined", is actually defined within the
kernel code, and I wanted it to be exported with "export_symbol"
macro. After re-compiling, the variable is actually presents in
/proc/kallsyms.  (but with type == 't'  -> section text, but not
global according to proc file..)

if I tried to compile a module using this variable, i got a warning
"undefined symbol", and for this reason, the module refuses to be
loaded with "insmod".

What I dont understand is the following:
The fonction printk, is also undifened and exported with the same
macro "export_symbol". but compilation doesnt complain about it!!

Am I missing a step somewhere?!
Thanks for any help,

sylvain
