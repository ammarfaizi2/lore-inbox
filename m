Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311166AbSCLNwo>; Tue, 12 Mar 2002 08:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311202AbSCLNwY>; Tue, 12 Mar 2002 08:52:24 -0500
Received: from calhau.terra.com.br ([200.176.3.20]:4531 "EHLO
	calhau.terra.com.br") by vger.kernel.org with ESMTP
	id <S311200AbSCLNwW>; Tue, 12 Mar 2002 08:52:22 -0500
Date: Tue, 12 Mar 2002 10:52:15 -0300
From: Lucio Maciel <abslucio@terra.com.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] zlib double-free fix
Message-Id: <20020312105215.0f2c1294.abslucio@terra.com.br>
Organization: Absoluta
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__12_Mar_2002_10:52:15_-0300_08268b98"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__12_Mar_2002_10:52:15_-0300_08268b98
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Forgot to attach the diff... sorry...
so here it goes..


Here is a small patch to fix the double-free in drivers/net/zlib.c

its against 2.4.19-pre3 but works fine in others versions

-- 
::: Lucio Maciel
::: abslucio@terra.com.br
::: Absoluta.Net :::

--Multipart_Tue__12_Mar_2002_10:52:15_-0300_08268b98
Content-Type: application/octet-stream;
 name="zlib.diff"
Content-Disposition: attachment;
 filename="zlib.diff"
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvbmV0L3psaWIuYy5vcmlnCVR1ZSBNYXIgMTIgMTA6MTU6MTYgMjAwMgorKysg
ZHJpdmVycy9uZXQvemxpYi5jCVR1ZSBNYXIgMTIgMTA6Mjk6MjggMjAwMgpAQCAtMzg2MCwxMCAr
Mzg2MCwxMiBAQAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcy0+c3ViLnRyZWVzLnRi
LCB6KTsKICAgICAgIGlmICh0ICE9IFpfT0spCiAgICAgICB7Ci0gICAgICAgIFpGUkVFKHosIHMt
PnN1Yi50cmVlcy5ibGVucyk7CiAgICAgICAgIHIgPSB0OwogICAgICAgICBpZiAociA9PSBaX0RB
VEFfRVJST1IpCisgICAgICAgIHsKICAgICAgICAgICBzLT5tb2RlID0gQkFEQjsKKyAgICAgICAg
ICBaRlJFRSh6LCBzLT5zdWIudHJlZXMuYmxlbnMpOworICAgICAgICB9CiAgICAgICAgIExFQVZF
CiAgICAgICB9CiAgICAgICBzLT5zdWIudHJlZXMuaW5kZXggPSAwOwpAQCAtMzkyOCwxNCArMzkz
MCwxNyBAQAogI2VuZGlmCiAgICAgICAgIHQgPSBpbmZsYXRlX3RyZWVzX2R5bmFtaWMoMjU3ICsg
KHQgJiAweDFmKSwgMSArICgodCA+PiA1KSAmIDB4MWYpLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHMtPnN1Yi50cmVlcy5ibGVucywgJmJsLCAmYmQsICZ0bCwgJnRkLCB6KTsK
LSAgICAgICAgWkZSRUUoeiwgcy0+c3ViLnRyZWVzLmJsZW5zKTsKICAgICAgICAgaWYgKHQgIT0g
Wl9PSykKICAgICAgICAgewogICAgICAgICAgIGlmICh0ID09ICh1SW50KVpfREFUQV9FUlJPUikK
KyAgICAgICAgICB7CiAgICAgICAgICAgICBzLT5tb2RlID0gQkFEQjsKKyAgICAgICAgICAgIFpG
UkVFKHosIHMtPnN1Yi50cmVlcy5ibGVucyk7CisgICAgICAgICAgfQogICAgICAgICAgIHIgPSB0
OwogICAgICAgICAgIExFQVZFCiAgICAgICAgIH0KKyAgICAgICAgWkZSRUUoeiwgcy0+c3ViLnRy
ZWVzLmJsZW5zKTsKICAgICAgICAgVHJhY2V2KChzdGRlcnIsICJpbmZsYXRlOiAgICAgICB0cmVl
cyBvaywgJWQgKiAlZCBieXRlcyB1c2VkXG4iLAogICAgICAgICAgICAgICBpbmZsYXRlX2h1ZnRz
LCBzaXplb2YoaW5mbGF0ZV9odWZ0KSkpOwogICAgICAgICBpZiAoKGMgPSBpbmZsYXRlX2NvZGVz
X25ldyhibCwgYmQsIHRsLCB0ZCwgeikpID09IFpfTlVMTCkK

--Multipart_Tue__12_Mar_2002_10:52:15_-0300_08268b98--
