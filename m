Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWDFBby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWDFBby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 21:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWDFBbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 21:31:53 -0400
Received: from wproxy.gmail.com ([64.233.184.233]:17524 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751245AbWDFBbx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 21:31:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZIeLQSmeb70+BhjQUD8nMmOG6Og0BewYuGdFz3ewqvLgFrEbmyLsWb7yB85xdgmGERmlQZpLR0f6jrZES1iLBek5NeIACDUBiLNJ96h4IFUxf1R25cVe6LueoCwkf9m6zC6xTGBYihrcHU+yoRRr46QpNaqtCiVcfN/rkuufLiI=
Message-ID: <6ff3e7140604051831h2bd07103s1ce472eedf338d3a@mail.gmail.com>
Date: Thu, 6 Apr 2006 09:31:50 +0800
From: "openbsd shen" <openbsd.shen@gmail.com>
To: kernel <linux-kernel@vger.kernel.org>
Subject: How can found a hiden module ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use this codes:

int init_module()
{
        if (module.next) module.next = module.next->next;
        ......

I can hide the next module, who can tell me how I can found the hide
module in system?


I think I can check /proc/ksyms against another /proc/ksyms from
truest system, of course, the checked system same as the truest
system, include system version, all loaded modules...
