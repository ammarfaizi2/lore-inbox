Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270967AbTGPRAF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270968AbTGPQ7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:59:32 -0400
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:64270 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S270967AbTGPQ6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:58:20 -0400
Message-Id: <5.1.0.14.0.20030716174759.02753238@212.67.194.181>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 16 Jul 2003 18:08:34 +0100
To: Roman Zippel <zippel@linux-m68k.org>
From: Michael Dransfield <mike@blueroot.net>
Subject: Re: PROBLEM: make xconfig segfaults, menuconfig fails
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0307161709230.717-100000@serv>
References: <5.1.0.14.0.20030716141023.02753380@212.67.194.181>
 <5.1.0.14.0.20030716141023.02753380@212.67.194.181>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_91506960==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_91506960==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 17:15 16/07/2003 +0200, Roman Zippel wrote:
>Hi,
>
>On Wed, 16 Jul 2003, Michael Dransfield wrote:
>
> > Typing 'make xconfig' segfaults - core dump can be sent if you need
>
>Your xconfig output doesn't make any sense, it shouldn't start compiling,
>did you really only 'make xconfig'?

just extracted the tar.bz2 file and the typed make xconfig.  Im not exactly 
a kernel hacker, so am following the directions in the Kernel-HOWTO

# nohup make modules 1> modules.out 2> modules.err &

produces compile errors (modules.out and modules.err attached)

>Anyway, a backtrace might be enough. ('gdb scripts/kconfig/qconf',
>'r arch/i386/Kconfig', 'bt')

i have attached the output from gdb, I normally get the xLib errors when 
starting X programs, it is a known problem when using mandrake 9.1 and 
tightvnc (which I am)


> > 'make menuconfig' produces errors and fails (output attached)
>
>You need to install the ncurses devel package.

thanks!  installed ncurses-5.3-1.20030215.1mdk and it worked



>bye, Roman

--=====================_91506960==_
Content-Type: text/plain; name="gdb.out";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="gdb.out"

Z2RiIHNjcmlwdHMva2NvbmZpZy9xY29uZgpHTlUgZ2RiIDUuMy0yMm1kayAoTWFuZHJha2UgTGlu
dXgpCkNvcHlyaWdodCAyMDAyIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLgpHREIgaXMg
ZnJlZSBzb2Z0d2FyZSwgY292ZXJlZCBieSB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Us
IGFuZCB5b3UgYXJlCndlbGNvbWUgdG8gY2hhbmdlIGl0IGFuZC9vciBkaXN0cmlidXRlIGNvcGll
cyBvZiBpdCB1bmRlciBjZXJ0YWluIGNvbmRpdGlvbnMuClR5cGUgInNob3cgY29weWluZyIgdG8g
c2VlIHRoZSBjb25kaXRpb25zLgpUaGVyZSBpcyBhYnNvbHV0ZWx5IG5vIHdhcnJhbnR5IGZvciBH
REIuICBUeXBlICJzaG93IHdhcnJhbnR5IiBmb3IgZGV0YWlscy4KVGhpcyBHREIgd2FzIGNvbmZp
Z3VyZWQgYXMgImk1ODYtbWFuZHJha2UtbGludXgtZ251Ii4uLgooZ2RiKSByIGFyY2gvaTM4Ni9L
Y29uZmlnClN0YXJ0aW5nIHByb2dyYW06IC9saW51eC9saW51eC0yLjYuMC10ZXN0MS9zY3JpcHRz
L2tjb25maWcvcWNvbmYgYXJjaC9pMzg2L0tjb25maWcKW05ldyBUaHJlYWQgMTYzODQgKExXUCAx
MzA4NCldClhsaWI6ICBleHRlbnNpb24gIkdMWCIgbWlzc2luZyBvbiBkaXNwbGF5ICI6MS4wIi4K
WGxpYjogIGV4dGVuc2lvbiAiR0xYIiBtaXNzaW5nIG9uIGRpc3BsYXkgIjoxLjAiLgpib29sZWFu
IHN5bWJvbCBCSU5GTVRfWkZMQVQgdGVzdGVkIGZvciAnbSc/IHRlc3QgZm9yY2VkIHRvICduJwoj
CiMgdXNpbmcgZGVmYXVsdHMgZm91bmQgaW4gLmNvbmZpZwojClhsaWI6ICBleHRlbnNpb24gIlJF
TkRFUiIgbWlzc2luZyBvbiBkaXNwbGF5ICI6MS4wIi4KClByb2dyYW0gcmVjZWl2ZWQgc2lnbmFs
IFNJR1NFR1YsIFNlZ21lbnRhdGlvbiBmYXVsdC4KW1N3aXRjaGluZyB0byBUaHJlYWQgMTYzODQg
KExXUCAxMzA4NCldCjB4NDA5ZDFjYTkgaW4gWGZ0RHJhd1N0cmluZzE2ICgpIGZyb20gL3Vzci9Y
MTFSNi9saWIvbGliWGZ0LnNvLjIKKGdkYikgYnQKIzAgIDB4NDA5ZDFjYTkgaW4gWGZ0RHJhd1N0
cmluZzE2ICgpIGZyb20gL3Vzci9YMTFSNi9saWIvbGliWGZ0LnNvLjIKKGdkYikgcXVpdAoK
--=====================_91506960==_
Content-Type: application/octet-stream; name="modules.err"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="modules.err"

ZHJpdmVycy9jaGFyL2VzcC5jOjExMDogd2FybmluZzogdHlwZSBkZWZhdWx0cyB0byBgaW50JyBp
biBkZWNsYXJhdGlvbiBvZiBgREVDTEFSRV9UQVNLX1FVRVVFJwpkcml2ZXJzL2NoYXIvZXNwLmM6
MTEwOiB3YXJuaW5nOiBwYXJhbWV0ZXIgbmFtZXMgKHdpdGhvdXQgdHlwZXMpIGluIGZ1bmN0aW9u
IGRlY2xhcmF0aW9uCmRyaXZlcnMvY2hhci9lc3AuYzogSW4gZnVuY3Rpb24gYHJzX3NjaGVkX2V2
ZW50JzoKZHJpdmVycy9jaGFyL2VzcC5jOjI3NTogd2FybmluZzogaW1wbGljaXQgZGVjbGFyYXRp
b24gb2YgZnVuY3Rpb24gYHF1ZXVlX3Rhc2snCmRyaXZlcnMvY2hhci9lc3AuYzoyNzU6IGB0cV9l
c3AnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQpkcml2ZXJzL2NoYXIv
ZXNwLmM6Mjc1OiAoRWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBv
bmNlCmRyaXZlcnMvY2hhci9lc3AuYzoyNzU6IGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMg
aW4uKQpkcml2ZXJzL2NoYXIvZXNwLmM6Mjc2OiB3YXJuaW5nOiBpbXBsaWNpdCBkZWNsYXJhdGlv
biBvZiBmdW5jdGlvbiBgbWFya19iaCcKZHJpdmVycy9jaGFyL2VzcC5jOjI3NjogYEVTUF9CSCcg
dW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCmRyaXZlcnMvY2hhci9lc3Au
YzogSW4gZnVuY3Rpb24gYHJlY2VpdmVfY2hhcnNfcGlvJzoKZHJpdmVycy9jaGFyL2VzcC5jOjM3
MTogc3RydWN0dXJlIGhhcyBubyBtZW1iZXIgbmFtZWQgYHRxdWV1ZScKZHJpdmVycy9jaGFyL2Vz
cC5jOjM3MTogYHRxX3RpbWVyJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlv
bikKZHJpdmVycy9jaGFyL2VzcC5jOiBJbiBmdW5jdGlvbiBgcmVjZWl2ZV9jaGFyc19kbWFfZG9u
ZSc6CmRyaXZlcnMvY2hhci9lc3AuYzo0NDY6IHN0cnVjdHVyZSBoYXMgbm8gbWVtYmVyIG5hbWVk
IGB0cXVldWUnCmRyaXZlcnMvY2hhci9lc3AuYzo0NDY6IGB0cV90aW1lcicgdW5kZWNsYXJlZCAo
Zmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCmRyaXZlcnMvY2hhci9lc3AuYzogSW4gZnVuY3Rp
b24gYGNoZWNrX21vZGVtX3N0YXR1cyc6CmRyaXZlcnMvY2hhci9lc3AuYzo2Mzk6IHdhcm5pbmc6
IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIGBzY2hlZHVsZV90YXNrJwpkcml2ZXJz
L2NoYXIvZXNwLmM6IEluIGZ1bmN0aW9uIGBkb19zZXJpYWxfYmgnOgpkcml2ZXJzL2NoYXIvZXNw
LmM6NzY4OiB3YXJuaW5nOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiBgcnVuX3Rh
c2tfcXVldWUnCmRyaXZlcnMvY2hhci9lc3AuYzo3Njg6IGB0cV9lc3AnIHVuZGVjbGFyZWQgKGZp
cnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQpkcml2ZXJzL2NoYXIvZXNwLmM6IEluIGZ1bmN0aW9u
IGBhdXRvY29uZmlnJzoKZHJpdmVycy9jaGFyL2VzcC5jOjIzOTg6IHdhcm5pbmc6IGBjaGVja19y
ZWdpb24nIGlzIGRlcHJlY2F0ZWQgKGRlY2xhcmVkIGF0IGluY2x1ZGUvbGludXgvaW9wb3J0Lmg6
MTE3KQpkcml2ZXJzL2NoYXIvZXNwLmM6IEluIGZ1bmN0aW9uIGBlc3BzZXJpYWxfaW5pdCc6CmRy
aXZlcnMvY2hhci9lc3AuYzoyNDgwOiB3YXJuaW5nOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBm
dW5jdGlvbiBgaW5pdF9iaCcKZHJpdmVycy9jaGFyL2VzcC5jOjI0ODA6IGBFU1BfQkgnIHVuZGVj
bGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQpkcml2ZXJzL2NoYXIvZXNwLmM6MjU3
MTogc3RydWN0dXJlIGhhcyBubyBtZW1iZXIgbmFtZWQgYHJvdXRpbmUnCmRyaXZlcnMvY2hhci9l
c3AuYzoyNTczOiBzdHJ1Y3R1cmUgaGFzIG5vIG1lbWJlciBuYW1lZCBgcm91dGluZScKZHJpdmVy
cy9jaGFyL2VzcC5jOiBJbiBmdW5jdGlvbiBgZXNwc2VyaWFsX2V4aXQnOgpkcml2ZXJzL2NoYXIv
ZXNwLmM6MjY0Mzogd2FybmluZzogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gYHJl
bW92ZV9iaCcKZHJpdmVycy9jaGFyL2VzcC5jOjI2NDM6IGBFU1BfQkgnIHVuZGVjbGFyZWQgKGZp
cnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQpkcml2ZXJzL2NoYXIvZXNwLmM6MjYzNTogd2Fybmlu
ZzogdW51c2VkIHZhcmlhYmxlIGBlMicKZHJpdmVycy9jaGFyL2VzcC5jOiBBdCB0b3AgbGV2ZWw6
CmRyaXZlcnMvY2hhci9lc3AuYzoxMTA6IHdhcm5pbmc6IGBERUNMQVJFX1RBU0tfUVVFVUUnIGRl
Y2xhcmVkIGBzdGF0aWMnIGJ1dCBuZXZlciBkZWZpbmVkCm1ha2VbMl06ICoqKiBbZHJpdmVycy9j
aGFyL2VzcC5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBbZHJpdmVycy9jaGFyXSBFcnJvciAyCm1h
a2U6ICoqKiBbZHJpdmVyc10gRXJyb3IgMgo=
--=====================_91506960==_
Content-Type: text/plain; name="modules.out";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="modules.out"

ICBDQyAgICAgIHNjcmlwdHMvZW1wdHkubwogIE1LRUxGICAgc2NyaXB0cy9lbGZjb25maWcuaAog
IEhPU1RDQyAgc2NyaXB0cy9maWxlMmFsaWFzLm8KICBIT1NUQ0MgIHNjcmlwdHMvbW9kcG9zdC5v
CiAgSE9TVExEICBzY3JpcHRzL21vZHBvc3QKbWFrZVsxXTogYHNjcmlwdHMva2NvbmZpZy9jb25m
JyBpcyB1cCB0byBkYXRlLgouL3NjcmlwdHMva2NvbmZpZy9jb25mIC1zIGFyY2gvaTM4Ni9LY29u
ZmlnCmJvb2xlYW4gc3ltYm9sIEJJTkZNVF9aRkxBVCB0ZXN0ZWQgZm9yICdtJz8gdGVzdCBmb3Jj
ZWQgdG8gJ24nCiMKIyB1c2luZyBkZWZhdWx0cyBmb3VuZCBpbiAuY29uZmlnCiMKICBTUExJVCAg
IGluY2x1ZGUvbGludXgvYXV0b2NvbmYuaCAtPiBpbmNsdWRlL2NvbmZpZy8qCm1ha2VbMV06IGBh
cmNoL2kzODYva2VybmVsL2FzbS1vZmZzZXRzLnMnIGlzIHVwIHRvIGRhdGUuCiAgQ0MgW01dICBk
cml2ZXJzL2NoYXIvZXNwLm8K
--=====================_91506960==_
Content-Type: text/plain; charset="us-ascii"; format=flowed


--=====================_91506960==_--

