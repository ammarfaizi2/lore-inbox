Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281440AbRKMC6C>; Mon, 12 Nov 2001 21:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281445AbRKMC5y>; Mon, 12 Nov 2001 21:57:54 -0500
Received: from seralph10.essex.ac.uk ([155.245.240.160]:18961 "EHLO
	seralph10.essex.ac.uk") by vger.kernel.org with ESMTP
	id <S281440AbRKMC5n>; Mon, 12 Nov 2001 21:57:43 -0500
Date: Mon, 12 Nov 2001 16:06:32 +0000
From: Ian Norton <ianort@essex.ac.uk>
To: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Kernel 2.4.14 compile fail (block.o)
Message-ID: <20011112160632.A11922@earth.dsh.org.uk>
Reply-To: bredroll@atari.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi :-), 

-- One Liner: make dep is fine but block.o fails to compile

--Problem: 
Make menuconfig for a pretty standard kernel, set for no driver modules, make
bzImage fails at block.o,

# drivers/block/block.o: In function `lo_send':
# drivers/block/block.o(.text+0x895f): undefined reference to `deactivate_page'
# drivers/block/block.o(.text+0x89a9): undefined reference to `deactivate_page'

The currently running system is going along just fine with 2.4.2 no problems
at all, good uptime,
Ive built plenty of kernels easily before, ive re created this problem on three
machines with very different linux setups (kernel, distro, gcc version..)

(menuconfigs saved and attached as bloc.o-fail.gz)

--- /proc/version
Linux version 2.4.2 (root@orion.dsh.org.uk) (gcc version 2.95.3 19991030
(prerelease)) #8 Thu Oct 4 15:59:45 BST 2001

--- ver_linux
linux orion.dsh.org.uk 2.4.2 #8 Thu Oct 4 15:59:45 BST 2001 i686 unknown
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.0.24
util-linux             2.10b
mount                  2.11b
modutils               2.4.3
e2fsprogs              1.19
PPP                    2.3.10
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.59
Console-tools          0.2.2
Sh-utils               2.0
Modules Loaded

--- host info
Machine Spec
CPU : 1x AMD Duron 800Mhz
RAM : 128Mb PC133
M/B : GIGABYTE (VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 3))

--- /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 800.042
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1595.80

--- lspci -vvv included as gzip
--- no scsi in system
--- no modules loaded at all (ever)

Hope this has been a helpful bug report

Ian Norton

--p4qYPpj5QlsIQJ0K
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="lspci-vvv.gz"
Content-Transfer-Encoding: base64

H4sICFuL8DsAA3BjaWluZm8A1ZhvU+I8EMBfy6fYlzIl2hasyIgzUNBjTjyOqveC8UVoU8hc
m3Ta1IP79M+2VJQ/J+pz553MVFKzu0k2v91N0PWGrh/o8EkmCsYx9yasAbe9FlwzdypkICec
JRXoCfegATfiu5A/BHjsnrsM9Kp+BPsxu8dWubTnpONknigWNuCCTygZzxV7NDPfVMdPac+W
QsUyaEDv8AuBPgs1aKdJn6KhWAMnYq49dwOWd33rXd0SuL1oOULKiMCAxt04JuAoFkVcTLDV
HQ4JnKN222wTnJOiKk0aYNNIA8vqT38SuOmcP4osbXS6t073shkyj6chnF23xjJWBE6XjX7e
0OBsMcbpIPsq7V1SxYSLq6uX9oZswqUAvZFNVsZzoAqYvvjAftUkY64qEMXMZ8qd0nHAyjBK
+E/WtGr9O/QFjeiYB1yhzxswovodtC4GcM/iJLNrHqC/lksafm1WDXDaLVxYDQ3jmr4RGOJ0
mjOjMjNR1JZhSIWXy+qZKMnskQ35UyEFO9sY38XxB/IHi6FPBZ2wkAn1OBm0fx7QCQoO+l07
+I4udHr4x8DHxIHSmZ3GMao09bCVyex3dFLB7gp2VzrVqVTZlysDj5SfrKujZ8KkKzL/ZEZZ
gJPvOC4NWHPRVyrpiK2B2A7s3muprefURrGcEO4jhDC6knFIA+x3pcfuyqtMau/ApPanmERe
2tlQUcxDGs+bul6BBJcpvPzNwLcULXhcZBjk78wlwUK9idroABizKRfe0s0ZzGN8SN7wfb+0
V9C+JuiN3Zx8gg3fzwUHT9CHcLvWMS20jmmh1c67bIUbgp7hav7g0yvZcxB/dD5uReGTsyFL
mHrq7zWq62+jWnsnqo+RalzVDqrh9rpu2lbdglErkkEgwUkjFt8t0nFNX03HO2wctvI4UjIf
eOHt3xsE2p9PzOS5IPhYie34wIBepwtcoKt96u6g4AgpyMQLEgoGdKv8mOXqFEaLnQOHuQMY
xHxw93JG1kd4/wy5Cof2++ComsuyXctXAxHKJ1nl9n2qF+XZsDar8z8PkQk3ThuKnQpYvHOP
27lCTo9By6s18uaT3VsjZv04d2IeNQyzWns9HdpOOrS/kzqsWgVc6k4ZBFwwyFgAHQ96vSwy
4zRSWFq5gA7EMlXMy1Po8CsYxi+h8ur6A1RVcxOqNxan94OqBk4/P1K8qi5Byx70flGc/s9d
gTxyRT5A1lnbbKv+T2/2CZ5E0H/gyjCiimdHNvdJMql2/BnkgUBdxe/ZAwBSelJCtahCxloe
QYNraWS7nS0EHB0/n1n+AgE+/v+l+69tpI3WWto42X6D9Nj6DRKva2TbLbJqZrfIwoaxYqP+
klvoir65nrncZeYyj7J62J1FVOSsDr/0cwnP9/NBRh5PMrve3fJ6+3kz11nP5TpjK/7aO+Lv
I/79NFA8C3MKNPW4XAkAm+NeJnCJ6c8F24GaZdQOTfPQrMHIjpFuGtgBo3jkkqnwztN8Xa3c
TMt1GdqgSj4c2TFQPtxvIc/VTdg3kASRQMhFBayiTWflnVHwpHiuhoHnM/9FYZDDtjUKilDa
bcLY8nNM7VW1WXvgNbs4att51ZBXfExtwav2Zl7/A85iAdTGEwAA

--p4qYPpj5QlsIQJ0K
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="block.o-fail.gz"
Content-Transfer-Encoding: base64

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

--p4qYPpj5QlsIQJ0K--
