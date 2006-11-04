Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752863AbWKBNWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbWKBNWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbWKBNWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:22:20 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:16295 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752863AbWKBNWT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:22:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ga0GqMM182AWZD7+NFvtD0ReHdMaSs2GdeJh5NT1CrWGlZTB8XZa4yn46UNWkyK7RDnIMG2FaXVQxe+xQ+saOUc6kuUkPYJy4sCF1f/nnRjLMFUEvhadoxf8UAb+3/ADQY0jJIpvTpBxbpwKXMHymAYZivuhXUyAgiKF5WFx/e4=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Andrew Morton <akpm@osdl.org>
Subject: [patch 4/6] Add output class document
Date: Sat, 4 Nov 2006 21:22:00 +0800
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611042122.00950.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add output class document

signed-off-by   Luming.yu@gmail.com
---
[patch 4/6] Add output class document
 video-output.txt |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/video-output.txt b/Documentation/video-output.txt
new file mode 100644
index 0000000..71b1dba
--- /dev/null
+++ b/Documentation/video-output.txt
@@ -0,0 +1,34 @@
+
+		Video Output Switcher Control
+		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+		2006 luming.yu@gmail.com
+
+The output sysfs class driver is to provide video output abstract layer that 
+can be used to hook platform specific methods to enable/disable video output
+device through common sysfs interface. For example, on my IBM Thinkpad T42 
+aptop, acpi video driver registered its output devices and read/write method
+for state with output sysfs class. The user interface under sysfs is :
+
+linux:/sys/class/video_output # tree .
+.
+|-- CRT0
+|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+|   |-- state
+|   |-- subsystem -> ../../../class/video_output
+|   `-- uevent
+|-- DVI0
+|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+|   |-- state
+|   |-- subsystem -> ../../../class/video_output
+|   `-- uevent
+|-- LCD0
+|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+|   |-- state
+|   |-- subsystem -> ../../../class/video_output
+|   `-- uevent
+`-- TV0
+   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+   |-- state
+   |-- subsystem -> ../../../class/video_output
+   `-- uevent
+
