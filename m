Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbTA0B1M>; Sun, 26 Jan 2003 20:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbTA0B1M>; Sun, 26 Jan 2003 20:27:12 -0500
Received: from web14611.mail.yahoo.com ([216.136.173.218]:57350 "HELO
	web14611.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267094AbTA0B1D>; Sun, 26 Jan 2003 20:27:03 -0500
Message-ID: <20030127013619.80551.qmail@web14611.mail.yahoo.com>
Date: Sun, 26 Jan 2003 17:36:19 -0800 (PST)
From: Arindam Dey <linuxkerneldeveloper@yahoo.com>
Subject: Re: Hard Disk Failure
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301242353230.14696-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2095205392-1043631379=:80129"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-2095205392-1043631379=:80129
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

--- Mark Hahn <hahn@physics.mcmaster.ca> wrote:
> > Now this Distribution is bundled along with its
> own
> > Hardware and about 45% of these PC's Harddisk are
> > failing after a period of 2-3 weeks. On
> reinstallation
> 
> not IBM DTLA's, I hope.
> 
> > they become ok but again after 2-3 weeks they fail
> > again and finally after 2 months of this the Hard
> Disk
> > fails COMPLETELY and cannot be used again for any
> 
> you need to get some actual data here, not this
> "completely" 
> nonsense.  do you mean it doesn't spin up?  if so,
> there's 
> nothing that the software (including the OS) could
> have done
> to cause it.
> 
> > All I want to know is what is the probability that
> the
> > above oversight of e2fsprogs version is
> responsible
> > for the HDD failure thats all. Since we are
> totally
> 
> no.  e2fsprogs might cause data loss, but not
> physical damage.
> 

I am  using Kernel -2.4.19. The ouput of /proc/ide/sis
is as follows
############# /proc/ide/sis
######################################
SiS 5513 Ultra 66 chipset
--------------- Primary Channel ----------------
Secondary Channel
-------------Channel Status: On                       
       Off
Operation Mode: Compatible                      
Compatible
Cable Type:     80 pins                          80
pins
Prefetch Count: 512                              512
Drive 0:        Postwrite Enabled               
Postwrite Disabled
              Prefetch  Enabled               
Prefetch  Disabled
              UDMA Enabled                     UDMA
Disabled
              UDMA Cycle Time    2 CLK         UDMA
Cycle Time    Reserved
              Data Active Time   3 PCICLK      Data
Active Time   8 PCICLK
              Data Recovery Time 1 PCICLK      Data
Recovery Time 12 PCICLK
Drive 1:        Postwrite Disabled              
Postwrite Disabled
              Prefetch  Disabled              
Prefetch  Disabled
              UDMA Enabled                     UDMA
Disabled
              UDMA Cycle Time    4 CLK         UDMA
Cycle Time    Reserved
              Data Active Time   3 PCICLK      Data
Active Time   8 PCICLK
              Data Recovery Time 1 PCICLK      Data
Recovery Time 12 PCICLK

#############the output of hdparm -i /dev/hda is as
follows############
Model=ExcelStor Technology ES3230, FwRev=ES7CA25A,
SerialNo=MA15HAX
Config={ Fixed }
RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
BuffType=DualPortCache, BuffSize=2048kB,
MaxMultSect=16, MultSect=16
CurCHS=16383/16/63, CurSects=-66060037, LBA=yes,
LBAsects=58615258
IORDY=on/off, tPIO={min:120,w/IORDY:120},
tDMA={min:120,rec:120}
PIO modes: pio0 pio1 pio2 pio3 pio4
DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2
AdvancedPM=no
Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4
ATA-5

The problem is random in nature it occurs on its own
giving dma error at boot time when it is checks the
hard disk.

hda: dma_intr: bad DMA status (dma_stat=35) ;
hda: dma_intr: status=0x50 { DriveReady SeekComplete }
hda: dma_intr: bad DMA status (dma_stat=35)  
hda: dma_intr: status=0x50 { DriveReady SeekComplete }
hda: dma_intr: bad DMA status (dma_stat=75)
The hexadecimal values of the status are different.

I have attched the dmesg and the lspci output also.

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
--0-2095205392-1043631379=:80129
Content-Type: application/octet-stream; name=dmesg
Content-Transfer-Encoding: base64
Content-Description: dmesg
Content-Disposition: attachment; filename=dmesg

TGludXggdmVyc2lvbiAyLjQuMTkgKHJvb3RAbG9jYWxob3N0LmxvY2FsZG9t
YWluKSAoZ2NjIHZlcnNpb24gMi45NiAyMDAwMDczMSAoUmVkIEhhdCBMaW51
eCA3LjEgMi45Ni05OCkpICMzIEZyaSBEZWMgMTMgMTQ6NTA6MzIgTVlUIDIw
MDIKQklPUy1wcm92aWRlZCBwaHlzaWNhbCBSQU0gbWFwOgogQklPUy1lODIw
OiAwMDAwMDAwMDAwMDAwMDAwIC0gMDAwMDAwMDAwMDA5ZmMwMCAodXNhYmxl
KQogQklPUy1lODIwOiAwMDAwMDAwMDAwMDlmYzAwIC0gMDAwMDAwMDAwMDBh
MDAwMCAocmVzZXJ2ZWQpCiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwZjAwMDAg
LSAwMDAwMDAwMDAwMTAwMDAwIChyZXNlcnZlZCkKIEJJT1MtZTgyMDogMDAw
MDAwMDAwMDEwMDAwMCAtIDAwMDAwMDAwMDZmZjAwMDAgKHVzYWJsZSkKIEJJ
T1MtZTgyMDogMDAwMDAwMDAwNmZmMDAwMCAtIDAwMDAwMDAwMDZmZjMwMDAg
KEFDUEkgTlZTKQogQklPUy1lODIwOiAwMDAwMDAwMDA2ZmYzMDAwIC0gMDAw
MDAwMDAwNzAwMDAwMCAoQUNQSSBkYXRhKQogQklPUy1lODIwOiAwMDAwMDAw
MGZmZmYwMDAwIC0gMDAwMDAwMDEwMDAwMDAwMCAocmVzZXJ2ZWQpCjExMU1C
IExPV01FTSBhdmFpbGFibGUuCkFkdmFuY2VkIHNwZWN1bGF0aXZlIGNhY2hp
bmcgZmVhdHVyZSBub3QgcHJlc2VudApPbiBub2RlIDAgdG90YWxwYWdlczog
Mjg2NTYKem9uZSgwKTogNDA5NiBwYWdlcy4Kem9uZSgxKTogMjQ1NjAgcGFn
ZXMuCnpvbmUoMik6IDAgcGFnZXMuCktlcm5lbCBjb21tYW5kIGxpbmU6IGF1
dG8gQk9PVF9JTUFHRT1saW51eCBybyByb290PTMwMiBCT09UX0ZJTEU9L2Jv
b3Qvdm1saW51ei0yLjQuMTktMS40IGNvbnNvbGU9L2Rldi90dHkzIENPTlNP
TEU9L2Rldi90dHkzIGNvbnNvbGU9dHR5UzAsOTYwMG44CkxvY2FsIEFQSUMg
ZGlzYWJsZWQgYnkgQklPUyAtLSByZWVuYWJsaW5nLgpGb3VuZCBhbmQgZW5h
YmxlZCBsb2NhbCBBUElDIQpJbml0aWFsaXppbmcgQ1BVIzAKRGV0ZWN0ZWQg
MTAwMi4yNzQgTUh6IHByb2Nlc3Nvci4KQ29uc29sZTogY29sb3VyIGR1bW15
IGRldmljZSA4MHgyNQpDYWxpYnJhdGluZyBkZWxheSBsb29wLi4uIDE5OTgu
ODQgQm9nb01JUFMKTWVtb3J5OiAxMTA3OTZrLzExNDYyNGsgYXZhaWxhYmxl
ICgxMTEwayBrZXJuZWwgY29kZSwgMzQ0MGsgcmVzZXJ2ZWQsIDQzOGsgZGF0
YSwgNDAwayBpbml0LCAwayBoaWdobWVtKQpEZW50cnkgY2FjaGUgaGFzaCB0
YWJsZSBlbnRyaWVzOiAxNjM4NCAob3JkZXI6IDUsIDEzMTA3MiBieXRlcykK
SW5vZGUgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA4MTkyIChvcmRlcjog
NCwgNjU1MzYgYnl0ZXMpCk1vdW50LWNhY2hlIGhhc2ggdGFibGUgZW50cmll
czogMjA0OCAob3JkZXI6IDIsIDE2Mzg0IGJ5dGVzKQpCdWZmZXItY2FjaGUg
aGFzaCB0YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjogMiwgMTYzODQgYnl0
ZXMpClBhZ2UtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAzMjc2OCAob3Jk
ZXI6IDUsIDEzMTA3MiBieXRlcykKQ1BVOiBCZWZvcmUgdmVuZG9yIGluaXQs
IGNhcHM6IDAzODNmYmZmIDAwMDAwMDAwIDAwMDAwMDAwLCB2ZW5kb3IgPSAw
CkNQVTogTDEgSSBjYWNoZTogMTZLLCBMMSBEIGNhY2hlOiAxNksKQ1BVOiBM
MiBjYWNoZTogMTI4SwpDUFU6IEFmdGVyIHZlbmRvciBpbml0LCBjYXBzOiAw
MzgzZmJmZiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMApJbnRlbCBtYWNo
aW5lIGNoZWNrIGFyY2hpdGVjdHVyZSBzdXBwb3J0ZWQuCkludGVsIG1hY2hp
bmUgY2hlY2sgcmVwb3J0aW5nIGVuYWJsZWQgb24gQ1BVIzAuCkNQVTogICAg
IEFmdGVyIGdlbmVyaWMsIGNhcHM6IDAzODNmYmZmIDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAwMDAwCkNQVTogICAgICAgICAgICAgQ29tbW9uIGNhcHM6IDAz
ODNmYmZmIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwCkNQVTogSW50ZWwg
Q2VsZXJvbiAoQ29wcGVybWluZSkgc3RlcHBpbmcgMGEKRW5hYmxpbmcgZmFz
dCBGUFUgc2F2ZSBhbmQgcmVzdG9yZS4uLiBkb25lLgpFbmFibGluZyB1bm1h
c2tlZCBTSU1EIEZQVSBleGNlcHRpb24gc3VwcG9ydC4uLiBkb25lLgpDaGVj
a2luZyAnaGx0JyBpbnN0cnVjdGlvbi4uLiBPSy4KUE9TSVggY29uZm9ybWFu
Y2UgdGVzdGluZyBieSBVTklGSVgKZW5hYmxlZCBFeHRJTlQgb24gQ1BVIzAK
RVNSIHZhbHVlIGJlZm9yZSBlbmFibGluZyB2ZWN0b3I6IDAwMDAwMDAwCkVT
UiB2YWx1ZSBhZnRlciBlbmFibGluZyB2ZWN0b3I6IDAwMDAwMDAwClVzaW5n
IGxvY2FsIEFQSUMgdGltZXIgaW50ZXJydXB0cy4KY2FsaWJyYXRpbmcgQVBJ
QyB0aW1lciAuLi4KLi4uLi4gQ1BVIGNsb2NrIHNwZWVkIGlzIDEwMDIuMjY3
MSBNSHouCi4uLi4uIGhvc3QgYnVzIGNsb2NrIHNwZWVkIGlzIDEwMC4yMjY1
IE1Iei4KY3B1OiAwLCBjbG9ja3M6IDEwMDIyNjUsIHNsaWNlOiA1MDExMzIK
Q1BVMDxUMDoxMDAyMjU2LFQxOjUwMTEyMCxEOjQsUzo1MDExMzIsQzoxMDAy
MjY1PgptdHJyOiB2MS40MCAoMjAwMTAzMjcpIFJpY2hhcmQgR29vY2ggKHJn
b29jaEBhdG5mLmNzaXJvLmF1KQptdHJyOiBkZXRlY3RlZCBtdHJyIHR5cGU6
IEludGVsClBDSTogUENJIEJJT1MgcmV2aXNpb24gMi4xMCBlbnRyeSBhdCAw
eGZiMGQwLCBsYXN0IGJ1cz0xClBDSTogVXNpbmcgY29uZmlndXJhdGlvbiB0
eXBlIDEKUENJOiBQcm9iaW5nIFBDSSBoYXJkd2FyZQpQQ0k6IFVzaW5nIElS
USByb3V0ZXIgU0lTIFsxMDM5LzAwMDhdIGF0IDAwOjAxLjAKTGludXggTkVU
NC4wIGZvciBMaW51eCAyLjQKQmFzZWQgdXBvbiBTd2Fuc2VhIFVuaXZlcnNp
dHkgQ29tcHV0ZXIgU29jaWV0eSBORVQzLjAzOQpJbml0aWFsaXppbmcgUlQg
bmV0bGluayBzb2NrZXQKU3RhcnRpbmcga3N3YXBkCkpvdXJuYWxsZWQgQmxv
Y2sgRGV2aWNlIGRyaXZlciBsb2FkZWQKQUNQSTogQ29yZSBTdWJzeXN0ZW0g
dmVyc2lvbiBbMjAwMTEwMThdCkFDUEk6IFN1YnN5c3RlbSBlbmFibGVkCkFD
UEk6IFN5c3RlbSBmaXJtd2FyZSBzdXBwb3J0cyBTMCBTMSBTNCBTNQpQcm9j
ZXNzb3JbMF06IEMwIEMxIEMyCkFDUEk6IFBvd2VyIEJ1dHRvbiAoRkYpIGZv
dW5kCkFDUEk6IE11bHRpcGxlIHBvd2VyIGJ1dHRvbnMgZGV0ZWN0ZWQsIGln
bm9yaW5nIGZpeGVkLWZlYXR1cmUKQUNQSTogUG93ZXIgQnV0dG9uIChDTSkg
Zm91bmQKQUNQSTogU2xlZXAgQnV0dG9uIChDTSkgZm91bmQKQUNQSTogVGhl
cm1hbCBab25lIGZvdW5kCnZlc2FmYjogZnJhbWVidWZmZXIgYXQgMHhkMDAw
MDAwMCwgbWFwcGVkIHRvIDB4Yzc4MTAwMDAsIHNpemUgMTYzODRrCnZlc2Fm
YjogbW9kZSBpcyA2NDB4NDgweDgsIGxpbmVsZW5ndGg9NjQwLCBwYWdlcz0y
NAp2ZXNhZmI6IHByb3RlY3RlZCBtb2RlIGludGVyZmFjZSBpbmZvIGF0IGNi
ZTU6MDAwYwp2ZXNhZmI6IHNjcm9sbGluZzogcmVkcmF3CkNvbnNvbGU6IHN3
aXRjaGluZyB0byBjb2xvdXIgZnJhbWUgYnVmZmVyIGRldmljZSA4MHgzMApm
YjA6IFZFU0EgVkdBIGZyYW1lIGJ1ZmZlciBkZXZpY2UKcHR5OiAyNTYgVW5p
eDk4IHB0eXMgY29uZmlndXJlZApTZXJpYWwgZHJpdmVyIHZlcnNpb24gNS4w
NWMgKDIwMDEtMDctMDgpIHdpdGggTUFOWV9QT1JUUyBTSEFSRV9JUlEgU0VS
SUFMX1BDSSBlbmFibGVkCnR0eVMwMCBhdCAweDAzZjggKGlycSA9IDQpIGlz
IGEgMTY1NTBBClVuaWZvcm0gTXVsdGktUGxhdGZvcm0gRS1JREUgZHJpdmVy
IFJldmlzaW9uOiA2LjMxCmlkZTogQXNzdW1pbmcgMzNNSHogc3lzdGVtIGJ1
cyBzcGVlZCBmb3IgUElPIG1vZGVzOyBvdmVycmlkZSB3aXRoIGlkZWJ1cz14
eApTSVM1NTEzOiBJREUgY29udHJvbGxlciBvbiBQQ0kgYnVzIDAwIGRldiAw
MQpTSVM1NTEzOiBjaGlwc2V0IHJldmlzaW9uIDIwOApTSVM1NTEzOiBub3Qg
MTAwJSBuYXRpdmUgbW9kZTogd2lsbCBwcm9iZSBpcnFzIGxhdGVyClNpUzYz
MAogICAgaWRlMDogQk0tRE1BIGF0IDB4NDAwMC0weDQwMDcsIEJJT1Mgc2V0
dGluZ3M6IGhkYTpETUEsIGhkYjpETUEKaGRhOiBFeGNlbFN0b3IgVGVjaG5v
bG9neSBFUzMyMzAsIEFUQSBESVNLIGRyaXZlCmhkYjogT0VNIENELVJPTSBG
NTYzRSwgQVRBUEkgQ0QvRFZELVJPTSBkcml2ZQppZGUwIGF0IDB4MWYwLTB4
MWY3LDB4M2Y2IG9uIGlycSAxNApoZGE6IDU4NjE1MjU4IHNlY3RvcnMgKDMw
MDExIE1CKSB3LzIwNDhLaUIgQ2FjaGUsIENIUz0zNjQ4LzI1NS82MywgVURN
QSg2NikKaGRiOiBBVEFQSSA1MlggQ0QtUk9NIGRyaXZlLCAxMjhrQiBDYWNo
ZSwgVURNQSgzMykKVW5pZm9ybSBDRC1ST00gZHJpdmVyIFJldmlzaW9uOiAz
LjEyClBhcnRpdGlvbiBjaGVjazoKIGhkYTogaGRhMSBoZGEyIGhkYTMgaGRh
NCA8IGhkYTUgPgpGbG9wcHkgZHJpdmUocyk6IGZkMCBpcyAxLjQ0TQpGREMg
MCBpcyBhIHBvc3QtMTk5MSA4MjA3NwpSQU1ESVNLIGRyaXZlciBpbml0aWFs
aXplZDogMTYgUkFNIGRpc2tzIG9mIDQwOTZLIHNpemUgMTAyNCBibG9ja3Np
emUKbG9vcDogbG9hZGVkIChtYXggOCBkZXZpY2VzKQpORVQ0OiBMaW51eCBU
Q1AvSVAgMS4wIGZvciBORVQ0LjAKSVAgUHJvdG9jb2xzOiBJQ01QLCBVRFAs
IFRDUCwgSUdNUApJUDogcm91dGluZyBjYWNoZSBoYXNoIHRhYmxlIG9mIDUx
MiBidWNrZXRzLCA0S2J5dGVzClRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJl
ZCAoZXN0YWJsaXNoZWQgODE5MiBiaW5kIDgxOTIpCk5FVDQ6IFVuaXggZG9t
YWluIHNvY2tldHMgMS4wL1NNUCBmb3IgTGludXggTkVUNC4wLgpram91cm5h
bGQgc3RhcnRpbmcuICBDb21taXQgaW50ZXJ2YWwgNSBzZWNvbmRzCkVYVDMt
ZnM6IG1vdW50ZWQgZmlsZXN5c3RlbSB3aXRoIG9yZGVyZWQgZGF0YSBtb2Rl
LgpWRlM6IE1vdW50ZWQgcm9vdCAoZXh0MyBmaWxlc3lzdGVtKSByZWFkb25s
eS4KZmJjb246IGNyZWF0aW5nIHByb2MgZW50cnkKRnJlZWluZyB1bnVzZWQg
a2VybmVsIG1lbW9yeTogNDAwayBmcmVlZApSZWFsIFRpbWUgQ2xvY2sgRHJp
dmVyIHYxLjEwZQpBZGRpbmcgU3dhcDogMjY1MDY0ayBzd2FwLXNwYWNlIChw
cmlvcml0eSAtMSkKdXNiLmM6IHJlZ2lzdGVyZWQgbmV3IGRyaXZlciB1c2Jk
ZXZmcwp1c2IuYzogcmVnaXN0ZXJlZCBuZXcgZHJpdmVyIGh1YgpQQ0k6IEZv
dW5kIElSUSAxMCBmb3IgZGV2aWNlIDAwOjAxLjIKUENJOiBTaGFyaW5nIElS
USAxMCB3aXRoIDAwOjAxLjMKdXNiLW9oY2kuYzogVVNCIE9IQ0kgYXQgbWVt
YmFzZSAweGM4ODRiMDAwLCBJUlEgMTAKdXNiLW9oY2kuYzogdXNiLTAwOjAx
LjIsIFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdIDcwMDEKdXNi
LmM6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1i
ZXIgMQpodWIuYzogVVNCIGh1YiBmb3VuZApodWIuYzogMyBwb3J0cyBkZXRl
Y3RlZApQQ0k6IEZvdW5kIElSUSAxMCBmb3IgZGV2aWNlIDAwOjAxLjMKUENJ
OiBTaGFyaW5nIElSUSAxMCB3aXRoIDAwOjAxLjIKdXNiLW9oY2kuYzogVVNC
IE9IQ0kgYXQgbWVtYmFzZSAweGM4ODRkMDAwLCBJUlEgMTAKdXNiLW9oY2ku
YzogdXNiLTAwOjAxLjMsIFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtT
aVNdIDcwMDEgKCMyKQp1c2IuYzogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwg
YXNzaWduZWQgYnVzIG51bWJlciAyCmh1Yi5jOiBVU0IgaHViIGZvdW5kCmh1
Yi5jOiAyIHBvcnRzIGRldGVjdGVkCkVYVDMgRlMgMi40LTAuOS4xNywgMTAg
SmFuIDIwMDIgb24gaWRlMCgzLDIpLCBpbnRlcm5hbCBqb3VybmFsCmtqb3Vy
bmFsZCBzdGFydGluZy4gIENvbW1pdCBpbnRlcnZhbCA1IHNlY29uZHMKRVhU
MyBGUyAyLjQtMC45LjE3LCAxMCBKYW4gMjAwMiBvbiBpZGUwKDMsMSksIGlu
dGVybmFsIGpvdXJuYWwKRVhUMy1mczogbW91bnRlZCBmaWxlc3lzdGVtIHdp
dGggb3JkZXJlZCBkYXRhIG1vZGUuCmtqb3VybmFsZCBzdGFydGluZy4gIENv
bW1pdCBpbnRlcnZhbCA1IHNlY29uZHMKRVhUMyBGUyAyLjQtMC45LjE3LCAx
MCBKYW4gMjAwMiBvbiBpZGUwKDMsNSksIGludGVybmFsIGpvdXJuYWwKRVhU
My1mczogbW91bnRlZCBmaWxlc3lzdGVtIHdpdGggb3JkZXJlZCBkYXRhIG1v
ZGUuCg==

--0-2095205392-1043631379=:80129
Content-Type: application/octet-stream; name=lspci
Content-Transfer-Encoding: base64
Content-Description: lspci
Content-Disposition: attachment; filename=lspci

MDA6MDAuMCBIb3N0IGJyaWRnZTogU2lsaWNvbiBJbnRlZ3JhdGVkIFN5c3Rl
bXMgW1NpU10gNjMwIEhvc3QgKHJldiAyMSkKCUZsYWdzOiBidXMgbWFzdGVy
LCBtZWRpdW0gZGV2c2VsLCBsYXRlbmN5IDMyCglNZW1vcnkgYXQgZDgwMDAw
MDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NjRNXQoJQ2Fw
YWJpbGl0aWVzOiBbYzBdIEFHUCB2ZXJzaW9uIDIuMAoKMDA6MDAuMSBJREUg
aW50ZXJmYWNlOiBTaWxpY29uIEludGVncmF0ZWQgU3lzdGVtcyBbU2lTXSA1
NTEzIFtJREVdIChyZXYgZDApIChwcm9nLWlmIDgwIFtNYXN0ZXJdKQoJU3Vi
c3lzdGVtOiBTaWxpY29uIEludGVncmF0ZWQgU3lzdGVtcyBbU2lTXSBTaVM1
NTEzIEVJREUgQ29udHJvbGxlciAoQSxCIHN0ZXApCglGbGFnczogYnVzIG1h
c3RlciwgZmFzdCBkZXZzZWwsIGxhdGVuY3kgMTYKCUkvTyBwb3J0cyBhdCA0
MDAwIFtzaXplPTE2XQoKMDA6MDEuMCBJU0EgYnJpZGdlOiBTaWxpY29uIElu
dGVncmF0ZWQgU3lzdGVtcyBbU2lTXSA4NUM1MDMvNTUxMwoJRmxhZ3M6IGJ1
cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxhdGVuY3kgMAoKMDA6MDEuMSBF
dGhlcm5ldCBjb250cm9sbGVyOiBTaWxpY29uIEludGVncmF0ZWQgU3lzdGVt
cyBbU2lTXSBTaVM5MDAgMTAvMTAwIEV0aGVybmV0IChyZXYgODMpCglTdWJz
eXN0ZW06IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdIFNpUzkw
MCAxMC8xMDAgRXRoZXJuZXQgQWRhcHRlcgoJRmxhZ3M6IGJ1cyBtYXN0ZXIs
IG1lZGl1bSBkZXZzZWwsIGxhdGVuY3kgMzIsIElSUSAxNQoJSS9PIHBvcnRz
IGF0IGUwMDAgW3NpemU9MjU2XQoJTWVtb3J5IGF0IGRkMTAxMDAwICgzMi1i
aXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTRLXQoJRXhwYW5zaW9uIFJP
TSBhdCA8dW5hc3NpZ25lZD4gW2Rpc2FibGVkXSBbc2l6ZT0xMjhLXQoJQ2Fw
YWJpbGl0aWVzOiBbNDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgow
MDowMS4yIFVTQiBDb250cm9sbGVyOiBTaWxpY29uIEludGVncmF0ZWQgU3lz
dGVtcyBbU2lTXSA3MDAxIChyZXYgMDcpIChwcm9nLWlmIDEwIFtPSENJXSkK
CVN1YnN5c3RlbTogU2lsaWNvbiBJbnRlZ3JhdGVkIFN5c3RlbXMgW1NpU10g
NzAwMQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxhdGVu
Y3kgMzIsIElSUSAxMAoJTWVtb3J5IGF0IGRkMTAyMDAwICgzMi1iaXQsIG5v
bi1wcmVmZXRjaGFibGUpIFtzaXplPTRLXQoKMDA6MDEuMyBVU0IgQ29udHJv
bGxlcjogU2lsaWNvbiBJbnRlZ3JhdGVkIFN5c3RlbXMgW1NpU10gNzAwMSAo
cmV2IDA3KSAocHJvZy1pZiAxMCBbT0hDSV0pCglTdWJzeXN0ZW06IFNpbGlj
b24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdOiBVbmtub3duIGRldmljZSA3
MDAwCglGbGFnczogYnVzIG1hc3RlciwgbWVkaXVtIGRldnNlbCwgbGF0ZW5j
eSAzMiwgSVJRIDEwCglNZW1vcnkgYXQgZGQxMDAwMDAgKDMyLWJpdCwgbm9u
LXByZWZldGNoYWJsZSkgW3NpemU9NEtdCgowMDowMi4wIFBDSSBicmlkZ2U6
IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdIDU1OTEvNTU5MiBB
R1AgKHByb2ctaWYgMDAgW05vcm1hbCBkZWNvZGVdKQoJRmxhZ3M6IGJ1cyBt
YXN0ZXIsIGZhc3QgZGV2c2VsLCBsYXRlbmN5IDAKCUJ1czogcHJpbWFyeT0w
MCwgc2Vjb25kYXJ5PTAxLCBzdWJvcmRpbmF0ZT0wMSwgc2VjLWxhdGVuY3k9
MAoJSS9PIGJlaGluZCBicmlkZ2U6IDAwMDBkMDAwLTAwMDBkZmZmCglNZW1v
cnkgYmVoaW5kIGJyaWRnZTogZGQwMDAwMDAtZGQwZmZmZmYKCVByZWZldGNo
YWJsZSBtZW1vcnkgYmVoaW5kIGJyaWRnZTogZDAwMDAwMDAtZDdmZmZmZmYK
CjAwOjBlLjAgTXVsdGltZWRpYSBhdWRpbyBjb250cm9sbGVyOiBDLU1lZGlh
IEVsZWN0cm9uaWNzIEluYyBDTTg3MzggKHJldiAxMCkKCVN1YnN5c3RlbTog
Qy1NZWRpYSBFbGVjdHJvbmljcyBJbmMgQ01JODczOC9DM0RYIFBDSSBBdWRp
byBEZXZpY2UKCUZsYWdzOiBidXMgbWFzdGVyLCBtZWRpdW0gZGV2c2VsLCBs
YXRlbmN5IDMyLCBJUlEgMTEKCUkvTyBwb3J0cyBhdCBlNDAwIFtzaXplPTI1
Nl0KCUNhcGFiaWxpdGllczogW2MwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNp
b24gMgoKMDA6MGUuMSBDb21tdW5pY2F0aW9uIGNvbnRyb2xsZXI6IEMtTWVk
aWEgRWxlY3Ryb25pY3MgSW5jIENNODczOCAocmV2IDIwKQoJU3Vic3lzdGVt
OiBDLU1lZGlhIEVsZWN0cm9uaWNzIEluYyBDTTg3MzgKCUZsYWdzOiBtZWRp
dW0gZGV2c2VsLCBJUlEgMTUKCUkvTyBwb3J0cyBhdCBlODAwIFtzaXplPTY0
XQoJQ2FwYWJpbGl0aWVzOiBbNDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lv
biAyCgowMTowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IFNpbGlj
b24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdIFNpUzYzMCBHVUkgQWNjZWxl
cmF0b3IrM0QgKHJldiAyMSkgKHByb2ctaWYgMDAgW1ZHQV0pCglTdWJzeXN0
ZW06IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdIFNpUzYzMCBH
VUkgQWNjZWxlcmF0b3IrM0QKCUZsYWdzOiA2Nk1oeiwgbWVkaXVtIGRldnNl
bAoJQklTVCByZXN1bHQ6IDAwCglNZW1vcnkgYXQgZDAwMDAwMDAgKDMyLWJp
dCwgcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xMjhNXQoJTWVtb3J5IGF0IGRkMDAw
MDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTEyOEtdCglJ
L08gcG9ydHMgYXQgZDAwMCBbc2l6ZT0xMjhdCglDYXBhYmlsaXRpZXM6IFs0
MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDEKCUNhcGFiaWxpdGllczog
WzUwXSBBR1AgdmVyc2lvbiAyLjAKCg==

--0-2095205392-1043631379=:80129--
