Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVK3HgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVK3HgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 02:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVK3HgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 02:36:23 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:53318 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751100AbVK3HgW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 02:36:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VUj2K3PMDyzRc42+1xpdCorEXGCYqpVk6FsukgZu3FH0BSx2Jv1R34rWYHh+zO1yzAub4JFdTkD0TrOGexI0un90fWIh5rySgXLzr12/fkLSjs4tVLG8ZUwKHvmxOmzu0sBbPgNaBA3konl5tg5MN9TSHveUOKilSmx9Y5vXK8k=
Message-ID: <3fe1d240511292336q335a8c9dh@mail.gmail.com>
Date: Wed, 30 Nov 2005 15:36:21 +0800
From: Hua Feijun <hua.feijun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: why does the function page_to_nid always return zero?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody:
Tthe following code deoes not work under linux/em64t, and the function
page_to_nid always return zero.Who can tell me the answer to the
problem?
Any advice will be appreciated sincerely.Thanks!!!

pgd = pgd_offset(mm, vaddr);
 if (pgd == NULL) {
   return -1;
 }
 pmd = pmd_offset(pgd, vaddr);
 if (pmd == NULL) {
     return -2;
 }
 pte = pte_offset_map(pmd, vaddr);
 PDEBUG("pte=%ul\n", pte->pte);
 if (pte == NULL) {
    return -3;
 }
return page_to_nid (page);
 if (pte_present(*pte) == NULL) {
    return -4;
 }
 page = pte_page(*pte);
 pte_unmap(pte);

return page_to_nid(page);
