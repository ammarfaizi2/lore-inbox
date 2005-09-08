Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVIHQDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVIHQDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVIHQDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:03:20 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:52843
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964881AbVIHQDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:03:19 -0400
Message-Id: <43207D28020000780002451E@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 18:04:24 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part72501C18.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part72501C18.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Allow building the x86-64 kernels with frame pointers if so needed.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/lib/Kconfig.debug
2.6.13-x86_64-frame-pointer/lib/Kconfig.debug
--- 2.6.13/lib/Kconfig.debug	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-x86_64-frame-pointer/lib/Kconfig.debug	2005-09-02
09:57:40.000000000 +0200
@@ -151,7 +151,7 @@ config DEBUG_FS
 
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
-	depends on DEBUG_KERNEL && ((X86 && !X86_64) || CRIS || M68K ||
M68KNOMMU || FRV || UML)
+	depends on DEBUG_KERNEL && (X86 || CRIS || M68K || M68KNOMMU ||
FRV || UML)
 	default y if DEBUG_INFO && UML
 	help
 	  If you say Y here the resulting kernel image will be slightly
larger


--=__Part72501C18.1__=
Content-Type: application/octet-stream; name="linux-2.6.13-x86_64-frame-pointer.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-x86_64-frame-pointer.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkFsbG93IGJ1aWxkaW5nIHRoZSB4ODYtNjQg
a2VybmVscyB3aXRoIGZyYW1lIHBvaW50ZXJzIGlmIHNvIG5lZWRlZC4KClNpZ25lZC1vZmYtYnk6
IEphbiBCZXVsaWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKZGlmZiAtTnBydSAyLjYuMTMvbGli
L0tjb25maWcuZGVidWcgMi42LjEzLXg4Nl82NC1mcmFtZS1wb2ludGVyL2xpYi9LY29uZmlnLmRl
YnVnCi0tLSAyLjYuMTMvbGliL0tjb25maWcuZGVidWcJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAw
MDAwMDAgKzAyMDAKKysrIDIuNi4xMy14ODZfNjQtZnJhbWUtcG9pbnRlci9saWIvS2NvbmZpZy5k
ZWJ1ZwkyMDA1LTA5LTAyIDA5OjU3OjQwLjAwMDAwMDAwMCArMDIwMApAQCAtMTUxLDcgKzE1MSw3
IEBAIGNvbmZpZyBERUJVR19GUwogCiBjb25maWcgRlJBTUVfUE9JTlRFUgogCWJvb2wgIkNvbXBp
bGUgdGhlIGtlcm5lbCB3aXRoIGZyYW1lIHBvaW50ZXJzIgotCWRlcGVuZHMgb24gREVCVUdfS0VS
TkVMICYmICgoWDg2ICYmICFYODZfNjQpIHx8IENSSVMgfHwgTTY4SyB8fCBNNjhLTk9NTVUgfHwg
RlJWIHx8IFVNTCkKKwlkZXBlbmRzIG9uIERFQlVHX0tFUk5FTCAmJiAoWDg2IHx8IENSSVMgfHwg
TTY4SyB8fCBNNjhLTk9NTVUgfHwgRlJWIHx8IFVNTCkKIAlkZWZhdWx0IHkgaWYgREVCVUdfSU5G
TyAmJiBVTUwKIAloZWxwCiAJICBJZiB5b3Ugc2F5IFkgaGVyZSB0aGUgcmVzdWx0aW5nIGtlcm5l
bCBpbWFnZSB3aWxsIGJlIHNsaWdodGx5IGxhcmdlcgo=

--=__Part72501C18.1__=--
