Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965568AbWKGRGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965568AbWKGRGB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965569AbWKGRGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:06:01 -0500
Received: from nz-out-0102.google.com ([64.233.162.198]:12620 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965568AbWKGRF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:05:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=Zz0osHEZm6rlCcwfPJ3s1fb3Qye0gVhR9EOaYo6RnpbMGOflNwcOKVGX0EAwpRRn6umMvPkIx6oochkf+jeo8aK1AzeowHcv1cQhdWv6J18jk6LsiPsRcuj2fUU633bwRoneRt1KZHYMAbITsQ7mmaYsIZrmpkFlzKG4jCLeIN8=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Andrew Morton <akpm@osdl.org>
Subject: [patch 4/5] Add output class document
Date: Wed, 8 Nov 2006 00:54:52 +0800
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611080054.53220.luming.yu@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 4/5: add output class document

signed-off-by: Luming Yu <Luming.yu@intel.com>
---
 video-output.txt |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/video-output.txt b/Documentation/video-output.txt
new file mode 100644
index 0000000..cf0f3c2
--- /dev/null
+++ b/Documentation/video-output.txt
@@ -0,0 +1,34 @@
+
+		Video Output Switcher Control
+		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+		2006 luming.yu@intel.com
+
+The output sysfs class driver provides an abstract video output layer that 
+can be used to hook platform specific methods to enable/disable video output
+device through common sysfs interface. For example, on my IBM ThinkPad T42 
+laptop, The ACPI video driver registered its output devices and read/write 
+method for 'state' with output sysfs class. The user interface under sysfs 
is:
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
