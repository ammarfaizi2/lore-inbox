Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286143AbRLTFvv>; Thu, 20 Dec 2001 00:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286144AbRLTFvm>; Thu, 20 Dec 2001 00:51:42 -0500
Received: from [202.135.142.194] ([202.135.142.194]:47878 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S286143AbRLTFvd>; Thu, 20 Dec 2001 00:51:33 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br
Subject: [PATCH] Documentation update
Date: Thu, 20 Dec 2001 16:51:21 +1100
Message-Id: <E16Gw6z-0000Aj-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone pointed out that cpu_to_XXX is not included in the Unreliable
Guide to Kernel Hacking.

Being aimed as a "fast background to kernel coding", it's a definite
hole.

Cheers,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.16-uml/Documentation/DocBook/kernel-hacking.tmpl working-2.4.16-uml-proc/Documentation/DocBook/kernel-hacking.tmpl
--- linux-2.4.16-uml/Documentation/DocBook/kernel-hacking.tmpl	Thu Oct 25 11:29:46 2001
+++ working-2.4.16-uml-proc/Documentation/DocBook/kernel-hacking.tmpl	Thu Dec 20 12:31:41 2001
@@ -18,8 +18,8 @@
   </authorgroup>
 
   <copyright>
-   <year>2000</year>
-   <holder>Paul Russell</holder>
+   <year>2001</year>
+   <holder>Rusty Russell</holder>
   </copyright>
 
   <legalnotice>
@@ -651,6 +651,28 @@
    </para> 
   </sect1>
  
+  <sect1 id="routines-endian">
+   <title><function>cpu_to_be32()</function>/<function>be32_to_cpu()</function>/<function>cpu_to_le32()</function>/<function>le32_to_cpu()</function>
+     <filename class=headerfile>include/asm/byteorder.h</filename> 
+   </title>
+
+   <para>
+    The <function>cpu_to_be32()</function> family (where the "32" can
+    be replaced by 64 or 16, and the "be" can be replaced by "le") are
+    the general way to do endian conversions in the kernel: they
+    return the converted value.
+   </para>
+
+   <para>
+    There are two major variations of these functions: the pointer
+    variation, such as <function>cpu_to_be32p()</function>, which take
+    a pointer to the given type, and return the converted value.  The
+    other variation is the "in-situ" family, such as
+    <function>cpu_to_be32s()</function>, which convert value referred
+    to by the pointer, and return void.
+   </para> 
+  </sect1>
+
   <sect1 id="routines-local-irqs">
    <title><function>local_irq_save()</function>/<function>local_irq_restore()</function>
     <filename class=headerfile>include/asm/system.h</filename>

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
