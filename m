Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVJEFkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVJEFkS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 01:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVJEFkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 01:40:18 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:50146 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932541AbVJEFkQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 01:40:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Fok9cDysSkAKz9fyiA3kBOi2Cee8EGhAFm3vHYv6OUdUGSZhAdSlwuEpblyTWPk23AW1JpvBHUqL6WjCX1mgkKpSj2FbTso2NDFMdGYfGoMBWD8FOCmNKCWL5Ys2KV2JgIW+ijyZU3G3mOERnb2qcxMBKRWTf+bf/rjWn5/i0ZM=
Message-ID: <309a667c0510042240y1dcc75c4l83abc7fe430e4f05@mail.gmail.com>
Date: Wed, 5 Oct 2005 11:10:15 +0530
From: devesh sharma <devesh28@gmail.com>
Reply-To: devesh sharma <devesh28@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [NUMA x86_64] problem accessing global Node List pgdat_list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
On an dual opteron machine and 2.6.9 kernel, I am accessing the global
node list pgdat_list but I am not getting the desired results

#include<linux/module.h>
#include<linux/config.h>
#include<linux/kernel.h>
#include<linux/mmzone.h>

struct pglist_data *pgdat_list ;

int init_module( void )
{

  pg_data_t *pg_dat ;

  printk ("<1>****Module initialized to retrive the information of
pgdat_list list in the Kernel****\n" ) ;


  for_each_pgdat(pg_dat)
  {
    printk ("<1>The number of zones on this node are %x\n", pg_dat ->
nr_zones ) ;

    printk ("<1>The Node Id of this node is %d\n", pg_dat -> node_id ) ;

  }

  return 0 ;
}

void cleanup_module ( void )
{
    printk ("<1>********Module Exiting***********\n" ) ;
}

MODULE_LICENSE("GPL") ;

How I can access this list any body tell me the solution.
