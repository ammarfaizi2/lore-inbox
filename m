Return-Path: <linux-kernel-owner+w=401wt.eu-S932571AbXAGPLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbXAGPLd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbXAGPLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:11:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:16365 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932571AbXAGPLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:11:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BspPr/IB39j6Ccq0EJLPqmxHROK5IDJQJcXXXNoL4Jb2E5Y3VI637Agkf94K1eT+i7K10J017N88EOtMGk2BWeHfVoud9TpL24/q6++NSMe3lvwaZqF99ZtBi0/bG1jLXTbI6L0YOWMrfVcUUfctCinComiIEoZjkKCaKHMe8/A=
Message-ID: <e7aeb7c60701070711q6008f2d2ua4487999fa9945c8@mail.gmail.com>
Date: Sun, 7 Jan 2007 17:11:31 +0200
From: "Yitzchak Eidus" <ieidus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: controling on witch cpu part of module code exectue
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am writing a module that have to make use in the vmx operations,
to enable vmx operations i have to set bit 13 (vmxe bit) in the
control registetr cr4 to 1.
doing so in a uni cpu platform is not a problem, the question is what
to do when working on smp system?
to make all the cpus in the smp system support the vmx operations i
have to set the that bit in cr4 in each one of them to 1.
running the code servel times might always run on just one cpu and
therefor not set any other cpu cr4 register to this value.
what i ask is:how to control in dynamic runtime on witch cpu ~parts~
of the code will run...
(the question isnt about if there is a simpler way to set up all the
cr4 registers in smp system, but it is more interesting to me how to
control in dynamic runtime on witch cpu code will exectue in kernel
mode)
thanks!
