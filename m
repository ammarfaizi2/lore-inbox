Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbVKHQys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbVKHQys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbVKHQys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:54:48 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:5217
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965136AbVKHQyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:54:46 -0500
Message-Id: <4370E69F.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 17:55:43 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: stand-alone CONFIG_PAE
References: <4370AEE1.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part1C3E229F.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part1C3E229F.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Separate the config option for PAE from that for high memory beyond
4G, allowing configurations with non-execute protection without any
(potential) other overhead coming from HIGHMEM64G.
Also appropriately qualify both options depending on configured
minimum processor type.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part1C3E229F.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-i386-pae.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-i386-pae.patch"

U2VwYXJhdGUgdGhlIGNvbmZpZyBvcHRpb24gZm9yIFBBRSBmcm9tIHRoYXQgZm9yIGhpZ2ggbWVt
b3J5IGJleW9uZAo0RywgYWxsb3dpbmcgY29uZmlndXJhdGlvbnMgd2l0aCBub24tZXhlY3V0ZSBw
cm90ZWN0aW9uIHdpdGhvdXQgYW55Cihwb3RlbnRpYWwpIG90aGVyIG92ZXJoZWFkIGNvbWluZyBm
cm9tIEhJR0hNRU02NEcuCkFsc28gYXBwcm9wcmlhdGVseSBxdWFsaWZ5IGJvdGggb3B0aW9ucyBk
ZXBlbmRpbmcgb24gY29uZmlndXJlZAptaW5pbXVtIHByb2Nlc3NvciB0eXBlLgoKRnJvbTogSmFu
IEJldWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+CgotLS0gMi42LjE0L2FyY2gvaTM4Ni9LY29u
ZmlnCTIwMDUtMTAtMjggMDI6MDI6MDguMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTQtaTM4Ni1w
YWUvYXJjaC9pMzg2L0tjb25maWcJMjAwNS0xMS0wNCAxNjoxOTozMi4wMDAwMDAwMDAgKzAxMDAK
QEAgLTczOSw3ICs3MzksNyBAQCBjb25maWcgSElHSE1FTTRHCiAJICBnaWdhYnl0ZXMgb2YgcGh5
c2ljYWwgUkFNLgogCiBjb25maWcgSElHSE1FTTY0RwotCWJvb2wgIjY0R0IiCisJYm9vbCAiNjRH
QiIgaWYgIU0zODYgJiYgIU00ODYgJiYgIU01ODYKIAloZWxwCiAJICBTZWxlY3QgdGhpcyBpZiB5
b3UgaGF2ZSBhIDMyLWJpdCBwcm9jZXNzb3IgYW5kIG1vcmUgdGhhbiA0CiAJICBnaWdhYnl0ZXMg
b2YgcGh5c2ljYWwgUkFNLgpAQCAtNzUyLDkgKzc1MiwxMSBAQCBjb25maWcgSElHSE1FTQogCWRl
ZmF1bHQgeQogCiBjb25maWcgWDg2X1BBRQotCWJvb2wKLQlkZXBlbmRzIG9uIEhJR0hNRU02NEcK
LQlkZWZhdWx0IHkKKwlib29sICJQQUUiIGlmICFISUdITUVNNjRHICYmICFNMzg2ICYmICFNNDg2
ICYmICFNNTg2CisJZGVmYXVsdCBISUdITUVNNjRHCisJaGVscAorCSAgU2VsZWN0IHRoaXMgaWYg
eW91IHdhbnQgdGhlIG5vLWV4ZWN1dGUgTU1VIGZ1bmN0aW9uYWxpdHkgZGVzcGl0ZQorCSAgeW91
ciBzeXN0ZW0gbm90IGhhdmluZyBtb3JlIHRoYW4gNCBnaWdhYnl0ZXMgb2YgUkFNLgogCiAjIENv
bW1vbiBOVU1BIEZlYXR1cmVzCiBjb25maWcgTlVNQQo=

--=__Part1C3E229F.0__=--
