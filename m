Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWC2GqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWC2GqP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 01:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWC2GqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 01:46:15 -0500
Received: from wproxy.gmail.com ([64.233.184.226]:22949 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751094AbWC2GqO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 01:46:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZAmVd0XrwBJbcBQsYhgydZ4opTbN2hlM+vKCSTqoGFWZ5NxbjYYnIDaPRH6cE+rK1eGOwVGwiDXiSOnx+4GDEXqxfHwDjz1KRjPMKh5Sx+MxPlOdYsB4YuUXiXHt0e9tA2kXZaYNuH4yIdvPr2CiV1xnHqIkIFE1dum2u9FCSko=
Message-ID: <4536bb730603282246m601a2e01q7cd0ecbd00ca4e24@mail.gmail.com>
Date: Wed, 29 Mar 2006 12:16:12 +0530
From: VASM <vasm85@gmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Setting the PSE bit
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
      I need some help for my project , I have 1024 contiguous 4 kb
pages in the memory (aligned to a 4mb boundary ) , i want to convert
these pages into one 4M page , I have written code in
do_anonymous_page()  , i have trapped my test program (which has a
mmap call for anonymous memory) in side this function and I want this
to work for this test process only , AFAIK the changes that need to be
done are , an new mk_pte_large should be added  where the PSE bit is
set and then use set_pte.
but is there any thing else that needs to be done , do we need to set
the pse bit in the pgd  , is yes , how ?
I am working on a intel 32 platform , I have read somewhere that a bit
in cr4 also needs to be set , is it already done or I'll have to do it
now.
and is there anything more that has to be done.

working on 2.4.32

--
Vasm
