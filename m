Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWIUBVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWIUBVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWIUBVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:21:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:2478 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750917AbWIUBVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:21:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=UjV+U3fON0ANoMWEr9ptxLKfkiYXZZVQ//4+uvy5NHXlQgyxCe8p2Hx3EXXkQcSsMmZhlitFKQOT6afaY/btjdfaYlM681340culRXPAOTRfRd8XYU6KbugD0BFUa0/5kLfOPufkh/VXP+o+aoHFsQCgw5mpMbS61slh33XB5og=
Message-ID: <94a0d4530609201821yb1aa4dcy8c5126a4062eb425@mail.gmail.com>
Date: Wed, 20 Sep 2006 20:21:19 -0500
From: "Felipe Contreras" <felipe.contreras@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix ACPI processor warnings
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_15652_13682349.1158801679152"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_15652_13682349.1158801679152
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch fixes the following warning:

WARNING: drivers/acpi/processor.o - Section mismatch: reference to
.init.data: from .text between 'acpi_processor_power_init' (at offset
0xeba) and 'acpi_safe_halt'

Someone that knows better should check it.

-- 
Felipe Contreras

------=_Part_15652_13682349.1158801679152
Content-Type: text/x-patch; name=linux-2.6.18-acpi-warnings.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_escgic9w
Content-Disposition: attachment; filename="linux-2.6.18-acpi-warnings.diff"

ZGlmZiAtdXIgbGludXgtMi42LjE4LW9yZy9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2NvcmUuYyBs
aW51eC0yLjYuMTgtbmV3L2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfY29yZS5jCi0tLSBsaW51eC0y
LjYuMTgtb3JnL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfY29yZS5jCTIwMDYtMDktMjAgMjA6MDA6
NDAuMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51eC0yLjYuMTgtbmV3L2RyaXZlcnMvYWNwaS9wcm9j
ZXNzb3JfY29yZS5jCTIwMDYtMDktMjAgMjA6MDU6MTAuMDAwMDAwMDAwIC0wNTAwCkBAIC01MTks
NyArNTE5LDcgQEAKIAogc3RhdGljIHZvaWQgKnByb2Nlc3Nvcl9kZXZpY2VfYXJyYXlbTlJfQ1BV
U107CiAKLXN0YXRpYyBpbnQgYWNwaV9wcm9jZXNzb3Jfc3RhcnQoc3RydWN0IGFjcGlfZGV2aWNl
ICpkZXZpY2UpCitzdGF0aWMgX19pbml0IGludCBhY3BpX3Byb2Nlc3Nvcl9zdGFydChzdHJ1Y3Qg
YWNwaV9kZXZpY2UgKmRldmljZSkKIHsKIAlpbnQgcmVzdWx0ID0gMDsKIAlhY3BpX3N0YXR1cyBz
dGF0dXMgPSBBRV9PSzsKZGlmZiAtdXIgbGludXgtMi42LjE4LW9yZy9kcml2ZXJzL2FjcGkvcHJv
Y2Vzc29yX2lkbGUuYyBsaW51eC0yLjYuMTgtbmV3L2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRs
ZS5jCi0tLSBsaW51eC0yLjYuMTgtb3JnL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jCTIw
MDYtMDktMjAgMjA6MDA6NDAuMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51eC0yLjYuMTgtbmV3L2Ry
aXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jCTIwMDYtMDktMjAgMjA6MDE6MTMuMDAwMDAwMDAw
IC0wNTAwCkBAIC0xMDc3LDcgKzEwNzcsNyBAQAogCS5yZWxlYXNlID0gc2luZ2xlX3JlbGVhc2Us
CiB9OwogCi1pbnQgYWNwaV9wcm9jZXNzb3JfcG93ZXJfaW5pdChzdHJ1Y3QgYWNwaV9wcm9jZXNz
b3IgKnByLAoraW50IF9faW5pdCBhY3BpX3Byb2Nlc3Nvcl9wb3dlcl9pbml0KHN0cnVjdCBhY3Bp
X3Byb2Nlc3NvciAqcHIsCiAJCQkgICAgICBzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSkKIHsK
IAlhY3BpX3N0YXR1cyBzdGF0dXMgPSAwOwo=
------=_Part_15652_13682349.1158801679152--
