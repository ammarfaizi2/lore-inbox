Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262773AbTCPWYY>; Sun, 16 Mar 2003 17:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262775AbTCPWYY>; Sun, 16 Mar 2003 17:24:24 -0500
Received: from 213-97-184-209.uc.nombres.ttd.es ([213.97.184.209]:46802 "HELO
	piraos.com") by vger.kernel.org with SMTP id <S262773AbTCPWYW>;
	Sun, 16 Mar 2003 17:24:22 -0500
Date: Sun, 16 Mar 2003 23:34:50 +0100
From: German Gomez Garcia <german@piraos.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with PCI IRQ routing
Message-ID: <20030316223450.GA654@piraos.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hello,

	I've just acquired a Conceptronics C11iDT Wireless card, it's
the PCI version, but in fact it's just a PCMCIA card plus a PCI-PCMCIA
adaptor. The problem is that I'm not able to make the adaptor works,
when I load the yenta_socket module (from linux kernel 2.4.20) I get:

PCI: No IRQ known for interrupt pin A of device 00:0d.0. Probably buggy MP table.
Yenta IRQ list 0000, PCI irq0
Socket status: 30000810

and if I disable the APIC (noapic option) I get

PCI: Enabling device 00:09.0 (0000 -> 0002)
PCI: No IRQ known for interrupt pin A of device 00:09.0. Please try using pci=biosirq.
Yenta IRQ list 0000, PCI irq0
Socket status: 30000810

if I try with pci=biosirq I get the same problem. 

When booting linux I get:

PCI: PCI BIOS revision 2.10 entry at 0xfd7e0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
BIOS failed to enable PCI standards compliance, fixing this error.
I/O APIC: AMD Errata #22 may be present. In the event of instability try
        : booting with the "noapic" option.

but it never caused any problem until now...

I've tried in other PCI slots with the same result (only the device
number changed).  I have linux kernel 2.4.20 and pcmcia-cs-3.2.4.
I'm running in a Tyan S2460 with BIOS 1.05. I've tried setting some IRQs
in the bios to be reserved and it doesn't get better. Also tried to
disable the IRQ Table in bios (option of the S2460 bios) with the same
result.

	I've attached lspci -v output, and /proc/interrupts, if you need
any more info I'll send as much as I could get.

	Best regards,

	- german

PS: Please CC'd to me as I'm not subscribed to the kernel list, thanks.

-- 
Send email with "SEND GPG KEY" as subject to receive my GnuPG public key.

--J/dobhs11T7y2rNN
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="lspci.output.gz"
Content-Transfer-Encoding: base64

H4sICJz7dD4AA2xzcGNpLm91dHB1dADFV9Fy2jgUfQ5fcfctmYFENsaYzHZniMmmtLh1oenu
lOFBtgVoYkuMbJOmX79XNhA7IVlId2Z5AAz3SjrnnnskEXJJyDmB9zLNIFA8WrBL6EdrKkIW
gcdDJWHA1jxkKUz73mAG+Nbq2gQ8H6bDm4HVMv0ZTB7SjCXgSpEpGcdMwaliazCMs8bJnzFd
pJcQ5CkkFMNUExIW8TyBiK1TFjchphkT4QPYVuPEY4lUD0AzYKR8wWnbbAU8a8JKsTnLwiUN
YnYG05T/ZO/Mju3NqmmRYR6QZn3EpOHFZ1hJlaU6z3DaBKYRT3VYNNvGYZhLVzTgMc84QxxT
SpCEGx/WTKVcCjDPSaNBkEcDefTd4S/QqIe9KrLhdKXkosXngEimn6RKaIx8hTJis/2c2ra3
/Pkitb1e4+Qqx5SV4glVD+8IaUKK44moeDLwKQ+kirjAjPKZha1N+ju7t6M4YEsuoh3IiBgF
3a2IzItX48Sv8I3r2ZtV1giz2pusgsEuMjic9I9h0IbpN75iyo/zdFYkF8oj5lHKI9v5DRgO
roELDJ7T8E1LwPxyCcbZYxUdClOvWANMWOiDr7j/QiFfaY6aYOda5KVKDXu2BdDeCOgNK++7
/nC39N3SasvZzmLB7eSq0u5vmE0PUE7WrfBkIKTP793hcdwYdhOG4y/QqxoB0hOFNSMQUrRe
MoMCmIP6u86WTAmWQVhBN2Y0ztgd1i7humfyMJMK8Z83YZRF5zD+Omo5Rrt3od/cjfkRxDDJ
g7TwxkPG0MnHSWIHu25lj8pAe6y7I/7VPoiUMvOJ93XQ+3x5jyr2qKALljCRPRphSWIPSXSp
itBudo08RsRLxKqRwnjUCa1up2TJIUdW2qnCsZ7tEa/V+FUHNJ84YKfugEbX3k18j1Ym74Fc
4vzlCloW6c6LhjytTf40xdApzjYlKFLK4j2Oqf/Uo7bKL9pRKwHGJsDaBlg6wLA1eojZgiJJ
O/t6lARGGmV5KJZn4k6GkKL8sIQ1nY/w95Fc8BAucE9PAi7TzfPpHPcgpuIH+OSOz6DTDp1e
p+IWFaF/ZXeKJvgRLoWM5eKhEHmh8YHbavfIrfnXMTU3re4LOrde17l1uM7rmcbhkrr+saKi
kP/4s6fzf88FTVO+ECz64/l5wt55TYB18PI44xo1hTWPmKzV4kpJeZcpxpA+hZhppme5ypyu
A9+KaGzOLFessuNVqtDHtiyH3hUCexiGIryEW3En5L3QTKNLl+I4pgnb5h6/1QevOnGvem2A
e20F/6HI+3nE/z/kFcetAzcPBx7WC08LQFX4rmKIeM1gRIMUcJsc4cNvcO3dGuTO2GDu1DHX
c9yvlj5bTq6KzP9kS3F2rdY2n+8LUfjKvmBscePhSqzybEv+AZi94WB4cUMThqOr7BDoOliv
Gj5I/J+Hd790xsJLgbOB7bwNdfRvbf4d9S1qQv8+btuk0/W/uJs+D/Ms42IB4ZKvUpbtV73H
8djlygQJxgX5SuoDRopXCjRdPFXpQ9deKub4+YyI/Q2OGjcPdsYGMS5JB9F/u+kj4GSF4PSF
oIrdo/j1B9woulryMG3qHj0HDxNutHfr61CJ1TqrX4hwzNkT+PuH4jiRELrWxYhe/++LQY5X
qfeMRojSC47yPdPZR4t5yD0V53qyzRgHnlwM++OTTOfATMd74wZ1lNDNZ+HzfTfkfwAEgF/o
ahAAAA==

--J/dobhs11T7y2rNN
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="proc_interrupts.gz"
Content-Transfer-Encoding: base64

H4sICPX7dD4AA3Byb2NfaW50ZXJydXB0cwCNkcGOgjAURff9ivcBNdPXWixuGRfEQYmOySST
WUBpIlGDocXo31sjARYOM13dxTm9uS1Ad6J0x/qIbSQAbP6MoRQi6HnWx6/PSRpHAK48mdob
2BqgENWocTC3vMrqwkt8/pJ8IenM6qww3lH/dmqnPR+2/HQWhLNR3t5OUmh1vVLInbtQWCQ7
ZEuk8B4hOx8b+81+KDQ2n1R7XVIwbs8IYLdCKilGG9LtG4ekaqwfgtN+CI5rZWEePXIgyL8E
JKsk/u2pyMc66n6YB6KLXAJZbDaDIk6SeDu8h9wBkzvDyUACAAA=

--J/dobhs11T7y2rNN--
