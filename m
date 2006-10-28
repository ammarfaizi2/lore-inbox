Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWJ1RXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWJ1RXH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 13:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWJ1RXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 13:23:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:24074 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751172AbWJ1RXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 13:23:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Q4etng6RW2AxYWZqS8bQs10TxCsjUZ1J9krj7i/EMnnFtdjboNBKk8HyePoEE7fVWN0wCz09Z4OSf/0OlT91j7xbpHTB3S82JewNFEBj7nV5Gx5WBjIZFoIJ8ruKTvBMuQOsiBsd66oxVI0Thn7yHnb7rBl+f03RApaJOoYAZzk=
Message-ID: <a2ebde260610281023x65c0bcd2ga34f7e50d0427259@mail.gmail.com>
Date: Sun, 29 Oct 2006 01:23:00 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: leave_mm() and lazy TLB mode
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places where some comments say leave_mm() disables
TLB flush on CPUs in lazy TLB mode.

My question may be silly, ...

leave_mm() change the value of CR3 register. In my understanding, that
causes TLB flush. Does this contradict with the definition of lazy TLB
mode?
