Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTIHXHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTIHXHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:07:31 -0400
Received: from [213.4.129.129] ([213.4.129.129]:63646 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id S263679AbTIHXHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:07:15 -0400
Date: Tue, 9 Sep 2003 01:07:02 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: /proc/ide/hdx/settings broken?
Message-Id: <20030909010702.7fede191.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__9_Sep_2003_01:07:02_+0200_09331650"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Tue__9_Sep_2003_01:07:02_+0200_09331650
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Today I realized that doing something like:

estel:/proc/ide/hda# echo "wcache:1" > settings 
or echo "using_dma:1" > settings

results in:
proc_ide_write_settings(): parse error
proc_ide_write_settings(): parse error

Searching in the list it seems it has been broken at least since July.
(This is test5)

Is this a know bug? 

.config attached.


00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y060L0, ATA DISK drive
Using anticipatory scheduling io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
hdd: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 120103200 sectors (61492 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 < hda5 hda6 hda7 hda8 > hda2 hda3



diego@estel:~$ cat /proc/ide/via 
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.37
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xd000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----

Transfer Mode:       UDMA       PIO      UDMA       DMA
Address Setup:       30ns     120ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      30ns      30ns
Cycle Time:          20ns     600ns      60ns     120ns
Transfer Rate:   99.9MB/s   3.3MB/s  33.3MB/s  16.6MB/s


--Multipart_Tue__9_Sep_2003_01:07:02_+0200_09331650
Content-Type: application/octet-stream;
 name="config.gz"
Content-Disposition: attachment;
 filename="config.gz"
Content-Transfer-Encoding: base64

H4sICJUIXT8CA2NvbmZpZwCMXElz4ziyvs+vYEwfXlVE9ytLlmR5IuoAgaCEFkHAAKilLgy1xbIV
LUseLd3tfz8JUgsXgPKhFuaX2BKJRGYC0C//+sVDx8P2bXFYPS/W6w/vJd2ku8UhXXpviz9T73m7
+bl6+Y+33G7+7+Cly9XhX7/8C/MooMNk1u99/zh/MBZfP2LqtwrYkEREUpxQhRKfIQCgkl88vF2m
0MrhuFsdPrx1+le69rbvh9V2s782QmYCyjISaRRCQSiV03FIUJRgzgQNibfae5vtwdunhyuH0ijy
UcijEnwCB5KPSXTtYv6d8ChRTJw7OMxksTblju/XLqkpEteSaq4mVOBi3wbKT4TkmCiVIIy1pX0o
hXV4rSXkUCwOEjWigf7e6l4ro+P8P9YxEjYgvk98SwtjFIZqztS1jSDWZHb9JIKHhR5QrvCI+EnE
uahTkarTfIL8kEbkLK5wu1gu/ljDnG6XR/hnf3x/3+4KCsO4H4ekUFNOSOIo5MivkQMucR3kA8VD
oonhEkiyouCBNCFSUR4pm0QAPvdV7LbP6X6/3XmHj/fUW2yW3s/UqGK6Lyl4Up5ZQ5nwORoSaZ0P
g0cxQ09OVMWMUe2EB3QICuiEJ1RNlRM9rTMk8cjJQ9TD3d2dFWb3/Z4d6LiAbgOgFXZijM3sWM9V
oQALQGNGqWViryAtacOJ3LHXOHa0NH5w0Pt2OglRZEewjBW3Gyc2pREegd3oNcLtRvTed7Q7l3RG
y6K6ohOK8H3SvqVFFjkbFDMxw6PhdT0a4gz5fpkSthKMwEqcDFr3jMmpIiwxNUCRBIVDLqkesXLh
qUimXI5VwsdlgEaTUFTaHpTNcbZmuUB+rfCQc2hRUFytU5MwiRWRmIt5GQNqIsCSJzASPIale4VH
8ZDocJAIsAUFqiA60bBdyQqNsDhEYLSkLjSfbzWnj0gmWMTqe/tMEJIQJnRFrhyj0DYKbiHCCiwT
GCZVawYkMPlRgGB/daqEYRIdPSKSObg0h4keICtG+2PboqUYtkjuk0oXlSwTQCjUL/YaNjxLdREf
0eGIkdJ+cCJ17JvnCe05YIb06DRvsKHYRqBlcZrRhMCWiM0UjS/bzPbvdAc+zmbxkr6lm8PZv/G+
ICzorx4S7GvuC53mnBXbyRDDCOzLvxabZ/DKcOaQHcFFg3qyfStvg24O6e7n4jn96qnLvnup11SS
jOzbTtZAtVWQuhfs0v8e083zh7cH33C1eSnWCAxJIMlTreTguL+OUmAYpMAMU/SrR8D/+9VjGP6C
/3297rPAVZw1+ITFOgA3w9rfHPapJFbPKodRVFjKhmSqK1PyGqoNh2SI8Dxz35ytR4gRe99gXA6T
bKcr/E/bsRuPuBZhPKzJl/yTPh8PmZ/1c2X+2u7Ahy54LQMaBQwsThgU3Nuchnisv79ViIyCmXgr
eLyrZ8/frf4CpeIXbzxDWfq23X14On1+3WzX25cPz0//WoEf5X1h2i8pMnzXei4W4Eyvwck32ln3
DsGZE1wW7N2JkLtgNRrsRGGrNHsnCCw5dVipQumABvwWj4pN7NHMxo1VtKnhCW+1+52LNVgfX/Il
u158WAQQFbYD+ABrMoiHBY/1sH3ervdFMYO+AaOt+UicND5flOvt85/eMp+tgqqEY2hkkgQ+KEBx
aNS3uy2mABZPiY8aYUwh8mngMW36CD/27hpZYrDOttjtBIcmUnmrF8NyLjQ3aGPt0cBvxCVijTiN
qJb2KsJBXfthg/0GfwT9xgL2TYZhXQFocTO8NOOTq/6kiz3EVWnq+dvno9lQsm3g22qZ/v/hn4Ox
Bd5run7/ttr83HqwP5h5XJq1XNKac9UjP6lMdL1tn6pxcZWdSAnsi5qagMuuKGc2pU1g3dwE9m2z
CABIizRPgU+CkAsxd/Uh0Qg6QTnE2pY+nBkCCtEm5WcxG5k8v67egfM8R9/+OL78XP1jFyNmfq9z
d6uj9nVaZMh2wWvXzE6jRkhC1+RTKb1wKsODYMCR9BuqPfny1tJC01671bwEfrQqwaJFQRiqbuAF
NNH46ZZkTA1ZrO/b5+jUQoJizauqCBCPwrnRtebCUyosZSMyTXxJwXMLqdI0GqqGwaI8d1UbAiK4
157NGoeJQtrqzu6beZj/0LlRT6ZrzSxa0iAkN6qZ99u499jcH6y63fbdTZb7ZpaR0Pc3emxYer1G
FoVbLkfpzCIobW4mUv2HTqvbXImP23cwmQkP/c8xggo193wyHatmDkoZRJE3eEDSreb5UiF+vCM3
BKklaz82LekJRaAbs9nMuhVVlsBpGdHJwL36qss2W3c8gkXZrBT1LVRhRU9OTGHzLDjTqh7IsOP6
sPqtXMj7IhH1M08snJQDMFZvNTjuTagFoXi97Xy/IIR4rfvHjvclWO3SKfz5em2qmMAuNWWKZaWq
DdI2bxilQaslovTw93b3J4RodaciIvq8sRXYanl2gfCYFIKD/DthDJXsJtQW0iibIcuMxxGdVbiT
MZnbdCPv1nVUIvcoMFL2KBUYkD9BEewSiYQwxpGABbbKRlvqDBW0CRxK+yoEX953DCIhOCoeBpgz
CT6mWZb72ivDiOxJ2bwSJdwgFeaYo64m4j/eZLU7HBdrT6U7E6+VkgMlpRHJxBGxiondYIBfBo3b
lyjEB0ObUwcFwJfSWfarKNqcmMcz1nGAZkIwe7AM4TqAKADRRpGWoJlXPc2BQIsqiUpcdCtzogZG
l94AjJg5MrLNdAY/xSQmtXaERgNzqlGhM6TxCNwKRnW9HzlIhUSRVZBFLoawvW4x1nouiB1kSI4d
iFlnWaRthTVXrv5KgsGM3eiuWQ/Win2FhR1BI7MAHAIk0VCPHF3VoQPAginHjIxICAbZjimNtEOe
TtXLYT6N6pWe1kKFqpEcwqqW5HeTfqqAEbKRYA0R2EwL4UGxJoYUaKZEPnE2dcp11ddDzgBLFOx8
w8I48SnESAOX6WmWoL7BoyImkgFS1kOGK1u+gmvkfK3XFDQahu6VdOp/yIcOEcU5ZB92rk5NdkOe
jEADj7HhKDPmI0SjT3EGUwg5LF4Q2LByGrjmZBSMe2L4k6Sy2WaVWLc6bc96TEIUJf27dssezoWh
PV06a9v97RCJgXMj9iEgk/ath8C/jl1pCh1s8AxMxQEy+QhgcXKMpkkQ8ilQgDGsyf5pq4zb+G27
834uVjvvv8f0mOaZ8UIl2fF44WQnJyV48FQnjvTAwql+1IlCZimKClXaWlKBpSVNnkILdRDUiUNr
rb7KNpUaHcJmSZQqA0+8QiAQX4Ot5LJMxqGqEWDB0cgv3lU4A9nkdRz0OjmY1mnxfdtSXk2Endqr
kwUPKSYVp9o7pPtD5YzEFIBNekgiu68ETjRUdEnSIok36aGQpS34n05fzI8Zs6e/BjzyYWrsy+gp
RiH94VgqOo6cC0QNqimh/FTi8JruTO+/tO48WB3AxP5YHb6WFwYxyfKK588c59QjJMScEcdmomJw
nJhdrMmERD6XyT0Y0uvsTcDjIaXoBJynES+f7GVj0cf16h3W99tq/eFtTtPrDshMizoOHYHFSLQc
eYtMOzBtFCUUPYuxcF5HImq3tn7YHtvnu+W69BGp/n3fkeUZgT+MR/bpmZMQ7GRA7Zoi+63eo33i
qGo92ptT48d+6KhQ0yGP7m/IyiIsOhva95nA9x16R4WwI6Iyx2eyKPkj8Jm72CZOttcDHLlraK8t
QRBG4mqdhgYe79xRxmTCS86rIQ6Ub5yJSlWOKymqMrxMjCaZsU73e89ccvmy2W5+e1287RbL1fZr
dQ2AA0rrqQm9/TPdeNLkHJbnw8Jl+p5ulntzQAF+w/ePUlUSuzJDCkxCWWZ5Fxcbb3U+/S6ZzSmq
L270tjikx50nzRhsyxmU3j4SuoPQ8Mtq83O32KXLr9bcjCxHj3k55UfA/Mf+Y39I38qnd34EZtri
Z2gQ+vvrdvNhO8wHq1W+05g3s3k/Hupm6pJIEPElDxTv093aZL9KYityJozHCkKOSSHkKNEToVA8
c6IKS0KiZPa9ddfuNPPMvz/0+sWMh2H6nc8rGaYKg1bNOJncwq2piEyG9BvPD812JW0aQvBjwmbb
bU4eR/6FoZAOIiWfLftMaP+u064S4e9T0au6ZwDW/TZ+aDksZsYiwCtznGWeGDAVqu0YbX6Efzrx
r+nBmMyzM6Zrf88UiBSg1WKHLwhszq4OXXhm+iZLRKbaevGmoEjFS6PZbS3VrpLy+wDldNxJx8Al
xeMmLeMxHuV66u4GLd6yymkCKzGWpXgyo8fZP/XLNq+L3eLZZL9qJ/STgjZNtMlCmNuvhVtH0wKt
NO0oNFn2/BK0tOTS091qsS7oeblov929K+voidjQXAaTmQbvi9QbjGDvMBxAyVq2XwI5VYW5JLXm
DbEuAZNzfuwnQs+VjQgF4kh/b3d713t15spfIQwJRb1WIXLjV3BAYJlZUvXYnqPHVtbRYrf8G3YP
kP5mv93tPbZYbf7YArV2pmDjxq/gl9qbAxnBCOodZKBOpTPrWGWrwqr0TxTftZPqqfspSctoOaHM
KGyVkR9ad+TD8+ty++JhGEFlR9Z45HPHfbwp+BDgudsTENGkciHj7C/o0vG2r0P7ipb3jz37TWAI
NCCgczSreDS33I8LDov39FcP3E/v53r7/v7hGcJ5+81XVXHgQVWq57aHpeMV+DRHxfZuGkw3YMxv
wlyDBzS7AutEown1KXLC4NC7sewar33Y5qDxut58yUofifaDWdGAGhpssMzeEYPKVrvvBpFPeOSE
2dBxb2+KJva1ItHp5oB0hE7RMLs0nN8Gth9LvqXL1cIW74PECa+esWUM/upldQDrOVkt06032G0X
y+dFlng438Ur1uOXz2VzzTWXBnNftMQLhrudBLbJAuQekNId3JyUzJDWtijm90HBY4CPy1W2q/wI
BbMOVQR29fndDc3cEKNg+F2g5Mxd8inm2qHksebucjnaqcC5YP3foMlv/sTPhH6V+cX954+93p0R
7SVq+52HlBT2/B/AFKjqd17k0ofYD2zt+1x9C5D+Fml7+4FJppcqYgrK2JVgcuE+22N97keRUJvn
jCqn9cug+/S43GZXWGsdM5dvKwoHayFw9AwgoVVSlNKFlCtopaITpAiOJdX25JlmwjHhp4v/1q7A
DhVc0nlstX9O1xBnpdvjvjLQq/r4DaoVuLGRGxqQBswNNZTC2bjsxwINi3EkGpZbNOu4UfOmzj7Z
cV35M0oyhakkrosRudFTdfFH7j4AZN9PycxEaq6es4FTitTVEhbOMtxHLizzYhn58YO7FUjZ7IJY
7A6r7NxIf7ynpTsgUlPz2OFy1aLkm4D/HV15rC1yFdzgQIwO0S0ejSS9wcMQtnOUTNmFo/o801wY
DNHA4fbk24iKB819gJABOqryN0eNnCYemZqrnM3thj67UVFEsIlrmrs1vCW8ONQSBnijmvjWbJOA
Ns5BFF6MYbQ4gEvshYvNy3HxkhbSWldek8NE0LXv/17tt/1+9/G3VvffhaEDh3kvZF5cJZ17+yu9
EtPDp5geuvauX1n6EAu/OYr3u+3bbfS73c8wfaK3fceV+QpT6zNMn+l47/4zTJ3PMH1GBI7LixWm
x9tMj/efqOmxe/eZmj4hp8fOJ/rUf3DLCdw6o/FJ/3Y1rfZnug1crZut3eZo3+S4v8lxe9Tdmxy9
mxwPNzkeb8vj9mBat0fTcg9nzGk/kc1w7DBHsQ76l3dau8X76+p5b8sGBba7uHlEqUiYP3k7/f7C
Zr8Fv2i52r+bB0l51qKek5vAhm3J+jH/QrZ55eZculAsTzpuj5tlIdln0uaX0+/zC8dwtTn+k7N6
aPf8ujqkz+ZhfqFcVIgu4QPG9RQT8FdkjZz3o0zmSplnnWUiozMiDVQmC8xOxOu+WGzQgLYDAeCR
GldeAhvqhMgBN4lqk4Ucl7Fz8FQlJYwwLufVTuSYT3TlIWTpJZ8lu5CVdV4byDpJJaOO89FMWFqg
iRM9pWvjVq/rsFRZHSLu3LXqzimmrj6jkHY7DquW4T/0/b0jB2RwrDo9x/OKE9zuu2sHlWndjd34
mMthq91qOxki1u72nCh48vftJvSx14x23aVHvuN6sQG1eewXaSc+Z4HzQDabFNVx3S3IpMpoU3ES
qdb9w90NvGFWVOvxvt8I99wwQ8RcCLt3MgSsf+dunGLSemiY8Qxvd9y4ybv2Z+7RKx5RPKED4rIx
2WON2axqGSazdrt+3gdThbxYDVzrC6AExbajb/6ebk4WWdVOsfPDT2GuH9YKmtZq+wkQr1kj02jp
nWs5bWIqqL1VyMuYu1PFpI+hDlDkT6mvR2WyP48g7sQmruPyEpOYukfb/cFshIfddr2Gzc+vn/ua
CsgI02SE7QkBw8AtDAU4PsHn/ds0fTp4xevFfm87b7ZORwkdhDHRnOtR9V5IictpybMGMHNip4My
+zOc8/sWA6bpEvZt8/jUjEsdtjsI8apDUZrLyiun6ywc3xab608YXJ+Vj2j5WbmpCGj2SoA+2AL1
/FLaJVTXwXMmLOfhWCYtKjQZO+Epcp0i5c1qNHALm0/Nr2tod+MzgewDp2+Ll8L9mupwmY/7DgOd
zQtGUWSZZVNz8ylFtrLQwDBWC2fHE53ck3NrSq366imoYTqn8BbLxTtoVn2JzPr91sPM8XNfJVaM
NHZPD5oSPXLPDxkiFSsnLnXYb3XdYoY/lSuclxFm0nHoaqzUQ/vOWux0gg/GCwoeSo57eYJrv4dw
nd+SrXV0QdNh6F4RMZFqikL3ipKUdxvUbyDDievXtAweNhhdTRyPxQw4RP7QIvDB+pgewEq82sQ1
qPODMfm5Wltf1gnJA3PLr+Cy85xGznZ+bG4nrr3XxfOfpVviues+Npdhw+KxhaGCIuMxhzjBXESv
gSEaVGmUg79eODNiaAh7nZor+VQrLmh0+n2aEt2kDFAISK3uKOCuSqAzhBSuTQcSMQhseOV6Rfar
YzMtkXnHrsr0gBovh2UXMIBW+SkgIZBU1+Axff7fICcFItoDSCtQMOdyIPJFlcBSIx3SXcamE3JY
BIY+n8ykosSiSoWi/NKSzLxUNC3OqE112Nycj6cTKMBQ12GCRTFWZ4KPgvNFO7fKA+2wJ9AJHvFB
rk7AKh7tYCdgSINWoYPP3gMAyqOm9sRRAAA=

--Multipart_Tue__9_Sep_2003_01:07:02_+0200_09331650--
