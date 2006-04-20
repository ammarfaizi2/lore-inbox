Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWDTOm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWDTOm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 10:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWDTOm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 10:42:26 -0400
Received: from spirit.analogic.com ([204.178.40.4]:47110 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750896AbWDTOmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 10:42:25 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C66488.A3054800"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 20 Apr 2006 14:42:24.0497 (UTC) FILETIME=[A3511E10:01C66488]
Content-class: urn:content-classes:message
Subject: Fix some spelling in 2.6.16.4 Makefile
Date: Thu, 20 Apr 2006 10:42:24 -0400
Message-ID: <Pine.LNX.4.61.0604201039120.5676@chaos.analogic.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Fix some spelling in 2.6.16.4 Makefile
Thread-Index: AcZkiKNaDpoQ7QUPSVC2MPX2dn/3DA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C66488.A3054800
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



I attached a patch just in case the mailer kills this.
This should be picked up by the janitor(s) so I didn't bother
with a "signed off"... The top-level Makefile has been getting
a few spelling errors over the years so it's probably time to fis.


--- /usr/src/linux-2.6.16.4/Makefile.orig	2006-04-20 10:07:43.000000000=
 -0400
+++ /usr/src/linux-2.6.16.4/Makefile	2006-04-20 10:35:32.000000000 -0400
@@ -197,7 +197,7 @@
  #	If we have only "make modules", don't compile built-in objects.
  #	When we're building modules with modversions, we need to consider
  #	the built-in objects during the descend as well, in order to
-#	make sure the checksums are uptodate before we record them.
+#	make sure the checksums are up to date before we record them.

  ifeq ($(MAKECMDGOALS),modules)
    KBUILD_BUILTIN :=3D $(if $(CONFIG_MODVERSIONS),1)
@@ -230,7 +230,7 @@
  #
  # If $(quiet) is empty, the whole command will be printed.
  # If it is set to "quiet_", only the short version will be printed.=0D
-# If it is set to "silent_", nothing wil be printed at all, since
+# If it is set to "silent_", nothing will be printed at all, since
  # the variable $(silent_cmd_cc_o_c) doesn't exist.
  #
  # A simple variant is to prefix commands with $(Q) - that's useful
@@ -378,7 +378,7 @@

  .PHONY: outputmakefile
  # outputmakefile generate a Makefile to be placed in output directory, if
-# using a seperate output directory. This allows convinient use
+# using a separate output directory. This allows convenient use
  # of make in output directory
  outputmakefile:
  	$(Q)if test ! $(srctree) -ef $(objtree); then \
@@ -451,7 +451,7 @@
  ifeq ($(KBUILD_EXTMOD),)
  # Additional helpers built in scripts/
  # Carefully list dependencies so we do not try to build scripts twice
-# in parrallel
+# in parallel
  .PHONY: scripts
  scripts: scripts_basic include/config/MARKER
  	$(Q)$(MAKE) $(build)=3D$(@)
@@ -482,7 +482,7 @@

  # If .config is newer than include/linux/autoconf.h, someone tinkered
  # with it and forgot to run make oldconfig.
-# If kconfig.d is missing then we are probarly in a cleaned tree so
+# If kconfig.d is missing then we are probably in a cleaned tree so
  # we execute the config step to be sure to catch updated Kconfig files
  include/linux/autoconf.h: .kconfig.d .config
  	$(Q)mkdir -p include/linux
@@ -495,7 +495,7 @@
  # The all: target is the default when no target is given on the
  # command line.
  # This allow a user to issue only 'make' to build a kernel including=
 modules
-# Defaults vmlinux but it is usually overriden in the arch makefile
+# Defaults vmlinux but it is usually overridden in the arch makefile
  all: vmlinux

  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
@@ -530,11 +530,11 @@
  # warn about C99 declaration after statement
  CFLAGS +=3D $(call cc-option,-Wdeclaration-after-statement,)

-# disable pointer signedness warnings in gcc 4.0
+# disable pointer signed / unsigned warnings in gcc 4.0
  CFLAGS +=3D $(call cc-option,-Wno-pointer-sign,)

  # Default kernel image to build when no specific target is given.
-# KBUILD_IMAGE may be overruled on the commandline or
+# KBUILD_IMAGE may be overruled on the command line or
  # set in the environment
  # Also any assignments in arch/$(ARCH)/Makefile take precedence over
  # this default value
@@ -548,7 +548,7 @@
  #
  # INSTALL_MOD_PATH specifies a prefix to MODLIB for module directory
  # relocations required by build roots.  This is not defined in the
-# makefile but the arguement can be passed to make if needed.
+# makefile but the argument can be passed to make if needed.
  #

  MODLIB	=3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
@@ -577,7 +577,7 @@

  # Build vmlinux
  #=
 --------------------------------------------------------------------------=
-
-# vmlinux is build from the objects selected by $(vmlinux-init) and
+# vmlinux is built from the objects selected by $(vmlinux-init) and
  # $(vmlinux-main). Most are built-in.o files from top-level directories
  # in the kernel tree, others are specified in arch/$(ARCH)Makefile.
  # Ordering when linking is important, and $(vmlinux-init) must be first.
@@ -778,7 +778,7 @@

  # If CONFIG_LOCALVERSION_AUTO is set scripts/setlocalversion is called
  # and if the SCM is know a tag from the SCM is appended.
-# The appended tag is determinded by the SCM used.
+# The appended tag is determined by the SCM used.
  #
  # Currently, only git is supported.
  # Other SCMs can edit scripts/setlocalversion and add the appropriate
@@ -1140,7 +1140,7 @@
  # make M=3Ddir modules   Make all modules in specified dir
  # make M=3Ddir	       Same as 'make M=3Ddir modules'
  # make M=3Ddir modules_install
-#                      Install the modules build in the module directory
+#                      Install the modules built in the module directory
  #                      Assumes install directory is already created

  # We are always building modules
@@ -1214,7 +1214,7 @@
  ALLINCLUDE_ARCHS :=3D $(ARCH)
  endif
  else
-#Allow user to specify only ALLSOURCE_PATHS on the command line, keeping=
 existing behaviour.
+#Allow user to specify only ALLSOURCE_PATHS on the command line, keeping=
 existing behavour.
  ALLINCLUDE_ARCHS :=3D $(ALLSOURCE_ARCHS)
  endif


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_
=1A=04


****************************************************************
The information transmitted in this message is confidential and may be=
 privileged.  Any review, retransmission, dissemination, or other use of=
 this information by persons or entities other than the intended recipient=
 is prohibited.  If you are not the intended recipient, please notify=
 Analogic Corporation immediately - by replying to this message or by=
 sending an email to DeliveryErrors@analogic.com - and destroy all copies=
 of this information, including any attachments, without reading or=
 disclosing them.

Thank you.
------_=_NextPart_001_01C66488.A3054800
Content-Type: TEXT/PLAIN;
	name="xxx.patch"
Content-Transfer-Encoding: base64
Content-Description: xxx.patch
Content-Disposition: attachment;
	filename="xxx.patch"

LS0tIC91c3Ivc3JjL2xpbnV4LTIuNi4xNi40L01ha2VmaWxlLm9yaWcJMjAwNi0wNC0yMCAxMDow
Nzo0My4wMDAwMDAwMDAgLTA0MDANCisrKyAvdXNyL3NyYy9saW51eC0yLjYuMTYuNC9NYWtlZmls
ZQkyMDA2LTA0LTIwIDEwOjM1OjMyLjAwMDAwMDAwMCAtMDQwMA0KQEAgLTE5Nyw3ICsxOTcsNyBA
QA0KICMJSWYgd2UgaGF2ZSBvbmx5ICJtYWtlIG1vZHVsZXMiLCBkb24ndCBjb21waWxlIGJ1aWx0
LWluIG9iamVjdHMuDQogIwlXaGVuIHdlJ3JlIGJ1aWxkaW5nIG1vZHVsZXMgd2l0aCBtb2R2ZXJz
aW9ucywgd2UgbmVlZCB0byBjb25zaWRlcg0KICMJdGhlIGJ1aWx0LWluIG9iamVjdHMgZHVyaW5n
IHRoZSBkZXNjZW5kIGFzIHdlbGwsIGluIG9yZGVyIHRvDQotIwltYWtlIHN1cmUgdGhlIGNoZWNr
c3VtcyBhcmUgdXB0b2RhdGUgYmVmb3JlIHdlIHJlY29yZCB0aGVtLg0KKyMJbWFrZSBzdXJlIHRo
ZSBjaGVja3N1bXMgYXJlIHVwIHRvIGRhdGUgYmVmb3JlIHdlIHJlY29yZCB0aGVtLg0KIA0KIGlm
ZXEgKCQoTUFLRUNNREdPQUxTKSxtb2R1bGVzKQ0KICAgS0JVSUxEX0JVSUxUSU4gOj0gJChpZiAk
KENPTkZJR19NT0RWRVJTSU9OUyksMSkNCkBAIC0yMzAsNyArMjMwLDcgQEANCiAjDQogIyBJZiAk
KHF1aWV0KSBpcyBlbXB0eSwgdGhlIHdob2xlIGNvbW1hbmQgd2lsbCBiZSBwcmludGVkLg0KICMg
SWYgaXQgaXMgc2V0IHRvICJxdWlldF8iLCBvbmx5IHRoZSBzaG9ydCB2ZXJzaW9uIHdpbGwgYmUg
cHJpbnRlZC4gDQotIyBJZiBpdCBpcyBzZXQgdG8gInNpbGVudF8iLCBub3RoaW5nIHdpbCBiZSBw
cmludGVkIGF0IGFsbCwgc2luY2UNCisjIElmIGl0IGlzIHNldCB0byAic2lsZW50XyIsIG5vdGhp
bmcgd2lsbCBiZSBwcmludGVkIGF0IGFsbCwgc2luY2UNCiAjIHRoZSB2YXJpYWJsZSAkKHNpbGVu
dF9jbWRfY2Nfb19jKSBkb2Vzbid0IGV4aXN0Lg0KICMNCiAjIEEgc2ltcGxlIHZhcmlhbnQgaXMg
dG8gcHJlZml4IGNvbW1hbmRzIHdpdGggJChRKSAtIHRoYXQncyB1c2VmdWwNCkBAIC0zNzgsNyAr
Mzc4LDcgQEANCiANCiAuUEhPTlk6IG91dHB1dG1ha2VmaWxlDQogIyBvdXRwdXRtYWtlZmlsZSBn
ZW5lcmF0ZSBhIE1ha2VmaWxlIHRvIGJlIHBsYWNlZCBpbiBvdXRwdXQgZGlyZWN0b3J5LCBpZg0K
LSMgdXNpbmcgYSBzZXBlcmF0ZSBvdXRwdXQgZGlyZWN0b3J5LiBUaGlzIGFsbG93cyBjb252aW5p
ZW50IHVzZQ0KKyMgdXNpbmcgYSBzZXBhcmF0ZSBvdXRwdXQgZGlyZWN0b3J5LiBUaGlzIGFsbG93
cyBjb252ZW5pZW50IHVzZQ0KICMgb2YgbWFrZSBpbiBvdXRwdXQgZGlyZWN0b3J5DQogb3V0cHV0
bWFrZWZpbGU6DQogCSQoUSlpZiB0ZXN0ICEgJChzcmN0cmVlKSAtZWYgJChvYmp0cmVlKTsgdGhl
biBcDQpAQCAtNDUxLDcgKzQ1MSw3IEBADQogaWZlcSAoJChLQlVJTERfRVhUTU9EKSwpDQogIyBB
ZGRpdGlvbmFsIGhlbHBlcnMgYnVpbHQgaW4gc2NyaXB0cy8NCiAjIENhcmVmdWxseSBsaXN0IGRl
cGVuZGVuY2llcyBzbyB3ZSBkbyBub3QgdHJ5IHRvIGJ1aWxkIHNjcmlwdHMgdHdpY2UNCi0jIGlu
IHBhcnJhbGxlbA0KKyMgaW4gcGFyYWxsZWwNCiAuUEhPTlk6IHNjcmlwdHMNCiBzY3JpcHRzOiBz
Y3JpcHRzX2Jhc2ljIGluY2x1ZGUvY29uZmlnL01BUktFUg0KIAkkKFEpJChNQUtFKSAkKGJ1aWxk
KT0kKEApDQpAQCAtNDgyLDcgKzQ4Miw3IEBADQogDQogIyBJZiAuY29uZmlnIGlzIG5ld2VyIHRo
YW4gaW5jbHVkZS9saW51eC9hdXRvY29uZi5oLCBzb21lb25lIHRpbmtlcmVkDQogIyB3aXRoIGl0
IGFuZCBmb3Jnb3QgdG8gcnVuIG1ha2Ugb2xkY29uZmlnLg0KLSMgSWYga2NvbmZpZy5kIGlzIG1p
c3NpbmcgdGhlbiB3ZSBhcmUgcHJvYmFybHkgaW4gYSBjbGVhbmVkIHRyZWUgc28NCisjIElmIGtj
b25maWcuZCBpcyBtaXNzaW5nIHRoZW4gd2UgYXJlIHByb2JhYmx5IGluIGEgY2xlYW5lZCB0cmVl
IHNvDQogIyB3ZSBleGVjdXRlIHRoZSBjb25maWcgc3RlcCB0byBiZSBzdXJlIHRvIGNhdGNoIHVw
ZGF0ZWQgS2NvbmZpZyBmaWxlcw0KIGluY2x1ZGUvbGludXgvYXV0b2NvbmYuaDogLmtjb25maWcu
ZCAuY29uZmlnDQogCSQoUSlta2RpciAtcCBpbmNsdWRlL2xpbnV4DQpAQCAtNDk1LDcgKzQ5NSw3
IEBADQogIyBUaGUgYWxsOiB0YXJnZXQgaXMgdGhlIGRlZmF1bHQgd2hlbiBubyB0YXJnZXQgaXMg
Z2l2ZW4gb24gdGhlDQogIyBjb21tYW5kIGxpbmUuDQogIyBUaGlzIGFsbG93IGEgdXNlciB0byBp
c3N1ZSBvbmx5ICdtYWtlJyB0byBidWlsZCBhIGtlcm5lbCBpbmNsdWRpbmcgbW9kdWxlcw0KLSMg
RGVmYXVsdHMgdm1saW51eCBidXQgaXQgaXMgdXN1YWxseSBvdmVycmlkZW4gaW4gdGhlIGFyY2gg
bWFrZWZpbGUNCisjIERlZmF1bHRzIHZtbGludXggYnV0IGl0IGlzIHVzdWFsbHkgb3ZlcnJpZGRl
biBpbiB0aGUgYXJjaCBtYWtlZmlsZQ0KIGFsbDogdm1saW51eA0KIA0KIGlmZGVmIENPTkZJR19D
Q19PUFRJTUlaRV9GT1JfU0laRQ0KQEAgLTUzMCwxMSArNTMwLDExIEBADQogIyB3YXJuIGFib3V0
IEM5OSBkZWNsYXJhdGlvbiBhZnRlciBzdGF0ZW1lbnQNCiBDRkxBR1MgKz0gJChjYWxsIGNjLW9w
dGlvbiwtV2RlY2xhcmF0aW9uLWFmdGVyLXN0YXRlbWVudCwpDQogDQotIyBkaXNhYmxlIHBvaW50
ZXIgc2lnbmVkbmVzcyB3YXJuaW5ncyBpbiBnY2MgNC4wDQorIyBkaXNhYmxlIHBvaW50ZXIgc2ln
bmVkIC8gdW5zaWduZWQgd2FybmluZ3MgaW4gZ2NjIDQuMA0KIENGTEFHUyArPSAkKGNhbGwgY2Mt
b3B0aW9uLC1Xbm8tcG9pbnRlci1zaWduLCkNCiANCiAjIERlZmF1bHQga2VybmVsIGltYWdlIHRv
IGJ1aWxkIHdoZW4gbm8gc3BlY2lmaWMgdGFyZ2V0IGlzIGdpdmVuLg0KLSMgS0JVSUxEX0lNQUdF
IG1heSBiZSBvdmVycnVsZWQgb24gdGhlIGNvbW1hbmRsaW5lIG9yDQorIyBLQlVJTERfSU1BR0Ug
bWF5IGJlIG92ZXJydWxlZCBvbiB0aGUgY29tbWFuZCBsaW5lIG9yDQogIyBzZXQgaW4gdGhlIGVu
dmlyb25tZW50DQogIyBBbHNvIGFueSBhc3NpZ25tZW50cyBpbiBhcmNoLyQoQVJDSCkvTWFrZWZp
bGUgdGFrZSBwcmVjZWRlbmNlIG92ZXINCiAjIHRoaXMgZGVmYXVsdCB2YWx1ZQ0KQEAgLTU0OCw3
ICs1NDgsNyBAQA0KICMNCiAjIElOU1RBTExfTU9EX1BBVEggc3BlY2lmaWVzIGEgcHJlZml4IHRv
IE1PRExJQiBmb3IgbW9kdWxlIGRpcmVjdG9yeQ0KICMgcmVsb2NhdGlvbnMgcmVxdWlyZWQgYnkg
YnVpbGQgcm9vdHMuICBUaGlzIGlzIG5vdCBkZWZpbmVkIGluIHRoZQ0KLSMgbWFrZWZpbGUgYnV0
IHRoZSBhcmd1ZW1lbnQgY2FuIGJlIHBhc3NlZCB0byBtYWtlIGlmIG5lZWRlZC4NCisjIG1ha2Vm
aWxlIGJ1dCB0aGUgYXJndW1lbnQgY2FuIGJlIHBhc3NlZCB0byBtYWtlIGlmIG5lZWRlZC4NCiAj
DQogDQogTU9ETElCCT0gJChJTlNUQUxMX01PRF9QQVRIKS9saWIvbW9kdWxlcy8kKEtFUk5FTFJF
TEVBU0UpDQpAQCAtNTc3LDcgKzU3Nyw3IEBADQogDQogIyBCdWlsZCB2bWxpbnV4DQogIyAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCi0jIHZtbGludXggaXMgYnVpbGQgZnJvbSB0aGUgb2JqZWN0cyBzZWxl
Y3RlZCBieSAkKHZtbGludXgtaW5pdCkgYW5kDQorIyB2bWxpbnV4IGlzIGJ1aWx0IGZyb20gdGhl
IG9iamVjdHMgc2VsZWN0ZWQgYnkgJCh2bWxpbnV4LWluaXQpIGFuZA0KICMgJCh2bWxpbnV4LW1h
aW4pLiBNb3N0IGFyZSBidWlsdC1pbi5vIGZpbGVzIGZyb20gdG9wLWxldmVsIGRpcmVjdG9yaWVz
DQogIyBpbiB0aGUga2VybmVsIHRyZWUsIG90aGVycyBhcmUgc3BlY2lmaWVkIGluIGFyY2gvJChB
UkNIKU1ha2VmaWxlLg0KICMgT3JkZXJpbmcgd2hlbiBsaW5raW5nIGlzIGltcG9ydGFudCwgYW5k
ICQodm1saW51eC1pbml0KSBtdXN0IGJlIGZpcnN0Lg0KQEAgLTc3OCw3ICs3NzgsNyBAQA0KIAkg
ICAgICAgDQogIyBJZiBDT05GSUdfTE9DQUxWRVJTSU9OX0FVVE8gaXMgc2V0IHNjcmlwdHMvc2V0
bG9jYWx2ZXJzaW9uIGlzIGNhbGxlZA0KICMgYW5kIGlmIHRoZSBTQ00gaXMga25vdyBhIHRhZyBm
cm9tIHRoZSBTQ00gaXMgYXBwZW5kZWQuDQotIyBUaGUgYXBwZW5kZWQgdGFnIGlzIGRldGVybWlu
ZGVkIGJ5IHRoZSBTQ00gdXNlZC4NCisjIFRoZSBhcHBlbmRlZCB0YWcgaXMgZGV0ZXJtaW5lZCBi
eSB0aGUgU0NNIHVzZWQuDQogIw0KICMgQ3VycmVudGx5LCBvbmx5IGdpdCBpcyBzdXBwb3J0ZWQu
DQogIyBPdGhlciBTQ01zIGNhbiBlZGl0IHNjcmlwdHMvc2V0bG9jYWx2ZXJzaW9uIGFuZCBhZGQg
dGhlIGFwcHJvcHJpYXRlDQpAQCAtMTE0MCw3ICsxMTQwLDcgQEANCiAjIG1ha2UgTT1kaXIgbW9k
dWxlcyAgIE1ha2UgYWxsIG1vZHVsZXMgaW4gc3BlY2lmaWVkIGRpcg0KICMgbWFrZSBNPWRpcgkg
ICAgICAgU2FtZSBhcyAnbWFrZSBNPWRpciBtb2R1bGVzJw0KICMgbWFrZSBNPWRpciBtb2R1bGVz
X2luc3RhbGwNCi0jICAgICAgICAgICAgICAgICAgICAgIEluc3RhbGwgdGhlIG1vZHVsZXMgYnVp
bGQgaW4gdGhlIG1vZHVsZSBkaXJlY3RvcnkNCisjICAgICAgICAgICAgICAgICAgICAgIEluc3Rh
bGwgdGhlIG1vZHVsZXMgYnVpbHQgaW4gdGhlIG1vZHVsZSBkaXJlY3RvcnkNCiAjICAgICAgICAg
ICAgICAgICAgICAgIEFzc3VtZXMgaW5zdGFsbCBkaXJlY3RvcnkgaXMgYWxyZWFkeSBjcmVhdGVk
DQogDQogIyBXZSBhcmUgYWx3YXlzIGJ1aWxkaW5nIG1vZHVsZXMNCkBAIC0xMjE0LDcgKzEyMTQs
NyBAQA0KIEFMTElOQ0xVREVfQVJDSFMgOj0gJChBUkNIKQ0KIGVuZGlmDQogZWxzZQ0KLSNBbGxv
dyB1c2VyIHRvIHNwZWNpZnkgb25seSBBTExTT1VSQ0VfUEFUSFMgb24gdGhlIGNvbW1hbmQgbGlu
ZSwga2VlcGluZyBleGlzdGluZyBiZWhhdmlvdXIuDQorI0FsbG93IHVzZXIgdG8gc3BlY2lmeSBv
bmx5IEFMTFNPVVJDRV9QQVRIUyBvbiB0aGUgY29tbWFuZCBsaW5lLCBrZWVwaW5nIGV4aXN0aW5n
IGJlaGF2b3VyLg0KIEFMTElOQ0xVREVfQVJDSFMgOj0gJChBTExTT1VSQ0VfQVJDSFMpDQogZW5k
aWYNCiANCg==

------_=_NextPart_001_01C66488.A3054800--
