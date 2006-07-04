Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWGDInx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWGDInx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWGDInx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:43:53 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:62792 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932126AbWGDInw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:43:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TSriQqXJddtRfzUocL+gLqEM7OQcGYCuH8EXzOKt+krwpwyfD4PiIQBBGG9H5Y5RB9OeSHIg0EsZJtF58FmLmI9Ylt0P8j89DiXod6xNTnv8WwCjKT5bgH3/yXDrKjPZhZ8kOfG62qj/9v2aAHBJ94BWWU9fegFjRhRZjzEWCcM=
Message-ID: <5d96567b0607040143y3aa06c8cn1b6e591d1a3bdc31@mail.gmail.com>
Date: Tue, 4 Jul 2006 11:43:51 +0300
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: netconsole
Cc: mpm@selenic.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt hello
I am testing netconsole.
What i did is to create a panic driver.
It is written bellow.
Why I am not getting the panic output to netcat ?

thank you
raz


xxxxxxxxxxxxxxxxxxxxxxxxxxxx

#include <linux/module.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/init.h>

static void do_panic_cleanup(void){}

static int do_panic_init(void){
        panic("raz");
        return -1;
}
module_init(do_panic_init);
module_exit(do_panic_cleanup);

MODULE_DESCRIPTION("do panic");
MODULE_AUTHOR("raz ben yehuda");
MODULE_LICENSE("GPL");



-- 
Raz
