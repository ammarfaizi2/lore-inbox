Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUKCMvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUKCMvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 07:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUKCMvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 07:51:17 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:5352 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261580AbUKCMuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 07:50:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=W2uoqdMC1q9A6WChJaCOa+0yFbeKEn/ebwrtZT7BQfS81PB/0fqEgkO8LfH73Ww8BjLuEQRJQ6bdiBRciaHNYBF/Ibk5g22Pjv63WgP/BZrpwCK4vbimsd3y2KZeoLET3+RBN3QEb/OkRax7dqmIUam1x7LFqO9wlQtWjDJGwE0=
Message-ID: <605a56ed041103045027f52b73@mail.gmail.com>
Date: Wed, 3 Nov 2004 14:50:10 +0200
From: Arne Henrichsen <ahenric@gmail.com>
Reply-To: Arne Henrichsen <ahenric@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to ship binary proprietary modules?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to get some clarification on how to ship binary
proprietary modules.

First some info. We want to ship our module in binary form, without
ever releasing the source. We have marked the module:
MODULE_LICENSE("Proprietary");
The module is written for Linux 2.6.X, also build using the kernel
build system. I have no problem loading the module, only when its
loaded for a different version, then I get the following error:
insmod: error inserting './mymodule.ko': -1 Invalid module format 

and in /var/log/messages:

kernel: mymodule: disagrees about version of symbol struct_module

I did compile my module under linux 2.6.8.1. and loaded it under
2.6.9. From what I understand of versioning it should check if the
software interface is valid still and then allow the module to be
loaded. Surely between version 2.6.8.1 and 2.6.9 nothing that drastic
changed?

Or do I totally misunderstood versioning? Must a customer for instance
request the module compiled for a specific kernel?

Thanks
Arne
