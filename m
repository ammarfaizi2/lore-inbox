Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVKGOoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVKGOoh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVKGOoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:44:37 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:48213
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750726AbVKGOog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:44:36 -0500
Message-Id: <436F7695.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 07 Nov 2005 15:45:25 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] x86_64: fix page fault from show_trace()
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartB99B9895.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartB99B9895.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The introduction of call_softirq switching to the interrupt stack
several releases earlier resulted in a problem with the code in
show_trace, which assumes that it can pick the previous stack pointer
from the end of the interrupt stack.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)

--=__PartB99B9895.1__=
Content-Type: application/octet-stream; name="linux-2.6.14-x86_64-call-softirq.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-x86_64-call-softirq.patch"

VGhlIGludHJvZHVjdGlvbiBvZiBjYWxsX3NvZnRpcnEgc3dpdGNoaW5nIHRvIHRoZSBpbnRlcnJ1
cHQgc3RhY2sKc2V2ZXJhbCByZWxlYXNlcyBlYXJsaWVyIHJlc3VsdGVkIGluIGEgcHJvYmxlbSB3
aXRoIHRoZSBjb2RlIGluCnNob3dfdHJhY2UsIHdoaWNoIGFzc3VtZXMgdGhhdCBpdCBjYW4gcGlj
ayB0aGUgcHJldmlvdXMgc3RhY2sgcG9pbnRlcgpmcm9tIHRoZSBlbmQgb2YgdGhlIGludGVycnVw
dCBzdGFjay4KCkZyb206IEphbiBCZXVsaWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKLS0tIDIu
Ni4xNC9hcmNoL3g4Nl82NC9rZXJuZWwvZW50cnkuUwkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAw
MDAwMCArMDIwMAorKysgMi42LjE0LW5sa2QvYXJjaC94ODZfNjQva2VybmVsL2VudHJ5LlMJMjAw
NS0xMS0wNyAxNDo1NjowMi4wMDAwMDAwMDAgKzAxMDAKQEAgLTEwMjQsMTcgKzEwMjQsMTUgQEAg
RU5UUlkobWFjaGluZV9jaGVjaykKIEVOVFJZKGNhbGxfc29mdGlycSkKIAlDRklfU1RBUlRQUk9D
CiAJbW92cSAlZ3M6cGRhX2lycXN0YWNrcHRyLCVyYXgKLQlwdXNocSAlcjE1Ci0JQ0ZJX0FESlVT
VF9DRkFfT0ZGU0VUIDgKLQltb3ZxICVyc3AsJXIxNQotCUNGSV9ERUZfQ0ZBX1JFR0lTVEVSCXIx
NQorCW1vdnEgJXJzcCwlcmR4CisJQ0ZJX0RFRl9DRkFfUkVHSVNURVIJcmR4CiAJaW5jbCAlZ3M6
cGRhX2lycWNvdW50CiAJY21vdmUgJXJheCwlcnNwCisJcHVzaHEgJXJkeAorCS8qdG9kbyBDRklf
REVGX0NGQV9FWFBSRVNTSU9OIC4uLiovCiAJY2FsbCBfX2RvX3NvZnRpcnEKLQltb3ZxICVyMTUs
JXJzcAorCXBvcHEgJXJzcAogCUNGSV9ERUZfQ0ZBX1JFR0lTVEVSCXJzcAogCWRlY2wgJWdzOnBk
YV9pcnFjb3VudAotCXBvcHEgJXIxNQotCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtOAogCXJldAog
CUNGSV9FTkRQUk9DCg==

--=__PartB99B9895.1__=--
