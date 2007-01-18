Return-Path: <linux-kernel-owner+w=401wt.eu-S932460AbXARTqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbXARTqX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 14:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbXARTqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 14:46:23 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:1670 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932460AbXARTqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 14:46:22 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZY5Q+bLDSP5S62ll1Q0wB63xRHpjAD+EORAdzYPwts7hkDjjRCXKdVH1vPXKSWYLIGwiqBhCw1miVb2co4do46OC88LYhFoLb5XeM6taOTuCZ0UlfaH4Cqsk97sWet2r17iNkrQqYHOePVNg1LszpCjKE+nf81EM8R7LYIumC0c=
Message-ID: <a02278b00701181146o2384d62ah8445ec3bb846a8da@mail.gmail.com>
Date: Thu, 18 Jan 2007 11:46:21 -0800
From: "Allexio Ju" <allexio.ju@gmail.com>
To: linux-pci@atrey.karlin.mff.cuni.cz, linas@austin.ibm.com
Subject: Questions on PCI express AER support in HBA driver
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got some questions on supporting PCI Express AER in Linux HBA drivers.
BTW, I'm developing SCSI HBA driver.

What are the expected changes on SCSI LLD driver in regards to PCIE
AER supporting? I understood that the driver need to call following
API during probing,
---
if (pci_find_aer_capability(dev)) {
    pci_enable_pcie_error_reporting(dev);
}
---
What else does SCSI LLD driver need to changed?

Thanks in advance.

Allexio
