Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVELMj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVELMj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVELMj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:39:27 -0400
Received: from tornado.reub.net ([60.234.136.108]:54959 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261621AbVELMjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:39:12 -0400
Message-ID: <42834E6D.8060408@reub.net>
Date: Fri, 13 May 2005 00:39:09 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050510)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm1
References: <20050512033100.017958f6.akpm@osdl.org>
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms020503030608090504000905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020503030608090504000905
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm1/
> 
> - Added Herbert Xu's ipsec tree to the -mm lineup, as git-ipsec.patch
> 
> - Lots of updates all over the place
> 
> 
> Changes since 2.6.12-rc3-mm3:

Just compiled this one up and this appeared in the log:

eth0: no IPv6 routers present
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:99!
invalid operand: 0000 [#1]
SMP
Modules linked in: nfsd exportfs lockd eeprom it87 i2c_sensor i2c_isa sunrpc 
ipv6 binfmt_misc dm_mod video thermal processor hotkey
fan button ac i2c_i801 sr_mod
CPU:    0
EIP:    0060:[<c034cc81>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12-rc4-mm1)
EIP is at _spin_unlock+0x24/0x2e
eax: 00000001   ebx: dfc5bf44   ecx: 00000400   edx: c03aa764
esi: dfb8f8e8   edi: dfc5be80   ebp: dfc5be78   esp: dfc5be78
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 144, threadinfo=dfc5a000 task=dfe13530)
Stack: dfc5bf1c c01cb806 4b1b5d0b 00000001 dead4ead 00000000 00000001 dfc5be94
        dfc5be94 00000000 dfc5bea0 dfc5bea0 00000000 00000000 00000000 00000000
        00000000 00000001 dead4ead dfc5bec4 dfc5bec4 dfc5bed0 00000001 dead4ead
Call Trace:
  [<c0103a43>] show_stack+0x94/0xca
  [<c0103bf7>] show_registers+0x165/0x1f9
  [<c0103e09>] die+0xf4/0x16f
  [<c01041b3>] do_invalid_op+0x97/0xa1
  [<c010369b>] error_code+0x4f/0x54
  [<c01cb806>] reiser4_sync_inodes+0x39/0x6f
  [<c01778b2>] sync_sb_inodes+0x14/0x20
  [<c0177928>] writeback_inodes+0x6a/0xd7
  [<c013f609>] wb_kupdate+0x82/0xeb
  [<c013fdeb>] __pdflush+0xcb/0x197
  [<c013fed5>] pdflush+0x1e/0x20
  [<c012f107>] kthread+0x99/0x9d
  [<c0101075>] kernel_thread_helper+0x5/0xb
Code: 00 65 e0 35 c0 eb e6 55 89 e5 89 c2 81 78 04 ad 4e ad de 75 0c 0f b6 02 
84 c0 7f 0f c6 02 01 5d c3 0f 0b 62 00 65 e0 35 c0 eb
ea <0f> 0b 63 00 65 e0 35 c0 eb e7 55 89 e5 f0 81 00 00 00 00 01 5d

This is new to -rc4-mm1.

Is the patch "reiser4-sb_sync_inodes-cleanup.patch" likely to be the culprit?

Reuben

--------------ms020503030608090504000905
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJdDCC
BLYwggKeoAMCAQICAwEFxDANBgkqhkiG9w0BAQQFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wNTAz
MzAxMTM3MzdaFw0wNjAzMzAxMTM3MzdaMDoxGDAWBgNVBAMTD1JldWJlbiBGYXJyZWxseTEe
MBwGCSqGSIb3DQEJARYPcmV1YmVuQHJldWIubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAuxqKwev5GpW3eVffSvZVDJm+rXuj8J+aHbSR9wffKM8qqR9DGR0FG23gB2wK
a1v0OFnX1dh2b04zqkVDjU/yYqEvn8JnS6+EmdoAyXmlR5fTHu9hxVfrB4xoSMo9nezxA9NG
y+noQFWzAqRH913fKweTgXVmoiqrpGAGpp0r3qv0S9LQUROOs2dCvir+ltwJwmECYQRvl3fe
H/toQTPJiHybe0r+ZInGCmpa+ISyVXXvFIe9/XpVtojBjJz3JFsCYPfdRNHLltnPK7n8PXJm
3deOmE0fsF32AUDl6AN7E8CB0A+Ublrnabfqwjh9XfFAAA5tsEiRxW2D5xUwMEIUwQIDAQAB
o4GFMIGCMAwGA1UdEwEB/wQCMAAwVgYJYIZIAYb4QgENBEkWR1RvIGdldCB5b3VyIG93biBj
ZXJ0aWZpY2F0ZSBmb3IgRlJFRSBoZWFkIG92ZXIgdG8gaHR0cDovL3d3dy5DQWNlcnQub3Jn
MBoGA1UdEQQTMBGBD3JldWJlbkByZXViLm5ldDANBgkqhkiG9w0BAQQFAAOCAgEApMBmI80Y
6Don1nasF49BCiB+2eM/CvF7PccdnQKGzyRE9mcyEiaFlpvpUx9BEw61gRRpVqEk7u1B1YXI
FNgW6ON13Gh+jQMUBx3hSMWSIJ9so2BOm/A6QM+sOBbP5JPbxv3K0I7hPRFv4NXiFpfcTUv2
XbFqd97n4d/RNchvz46bV7ALIRlYBQS+0NypmjAwQpr0LLZ6F1jnuKqamlmAwEJKH5nM2joI
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
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCB
kQYJKwYBBAGCNxAEMYGDMIGAMHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsTFWh0dHA6
Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhvcml0eTEh
MB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnAgMBBcQwgZMGCyqGSIb3DQEJEAIL
MYGDoIGAMHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsTFWh0dHA6Ly93d3cuY2FjZXJ0
Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhvcml0eTEhMB8GCSqGSIb3DQEJ
ARYSc3VwcG9ydEBjYWNlcnQub3JnAgMBBcQwDQYJKoZIhvcNAQEBBQAEggEAKJtqULoN6EGr
gWUOhmueKeNl9c/dXa+MZ0h6KBMvPF2/F8SBGLNGnu87by1mwHJONk2PedcQ2QHl/HFugayt
asYmnhxoAvI+WRkvxqRWBznbZ8WcZ2bgdr6z7x8wRx9c9DKjaS3Jj2udoKwbkRHoeng6Kjdj
heTq9Te52iZ0XSblSS2Nw+9UrRIO23FcsyEfAutLe6Zi3PfaE0gsOGHtj8QKvtZ97C610Ul0
ekLy6yoEiAKlf8dypgTOoj/5X+q4huGWkdIt791ATIbIlRjfS0SrAMeLFHRqfgKVDh/mjewa
y6CV8B4/5+D8i11PT1t4N1z8a12l/Agfy0d9NlgWuQAAAAAAAA==
--------------ms020503030608090504000905--
