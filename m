Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbTIDQdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbTIDQdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:33:39 -0400
Received: from host.atlantis.bg ([193.108.24.7]:10923 "HELO host.atlantis.bg")
	by vger.kernel.org with SMTP id S265298AbTIDQc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:32:58 -0400
Message-ID: <3F576935.9030707@atlantis.bg>
Date: Thu, 04 Sep 2003 19:32:53 +0300
From: Ventsislav Genchev <vigour@atlantis.bg>
Organization: Atlantis BG, Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en, bg
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: airo.o problem
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms030101030307020103050202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms030101030307020103050202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've got a RedHat 9 Linux 2.4.20-20.9 box with Cisco aironet 350 series 
wireless adapter.
The problem appears when I start tcpdump on that interface. For few 
second everything seems normal, but after couple of second the traffic 
hangs down. The signal strength and quolity matter show that it's 
working just fine, but neither there is ping response or any traffic 
passes through the interface.
I maintain few linux boxes and noticed that problem with RedHat 8.0.
The latest Redhat distro hasing no problems is 7.3 with kernel 2.4.18-3.
Any latest version hangs down...

here is some informatios as recomended:

lsmod:
airo                   49672   1
ne2k-pci                7232   1
8390                    8524   0  [ne2k-pci]
8139too                18120   0  (unused)
mii                     3976   0  [8139too]
keybdev                 2976   0  (unused)
mousedev                5556   0  (unused)
hid                    22244   0  (unused)
input                   5856   0  [keybdev mousedev hid]
usb-uhci               26412   0  (unused)
usbcore                79040   1  [hid usb-uhci]
ext3                   70784   2
jbd                    51924   2  [ext3]

There is no indication fot trouble in /var/log/messages

Shell script .. hmm
(install Cisco Aironet 350 Series Wireless Adapter) and run:
#!/bin/bash
modprobe airo
ifconfig eth0 192.168.0.1
echo "SSID" > /proc/driver/aironet/eth0/SSID
tcpdump -qn -i eth0

Notice that there must be a traffic going throug the access poit (some 
other clients must be connected too, and generate traffic). I've tested 
the situation when only I was a client in that AP and no problem 
occured. (Hope that will help you)

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 367.507
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 734.00

But I may be repeating myself by saying that this is not a single box 
problem.

Here is the PCI information:

00:14.0 Network controller: AIRONET Wireless Communications PC4800 (rev 01)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at effffe80 (32-bit, non-prefetchable) [size=128]
        Region 1: I/O ports at d800 [size=128]
        Region 2: I/O ports at d600 [size=64]

no SCSI...
no patches or fixes (except that provided by RedHat)


Regards, and please excuse my english...

 -- 
=========================================================
| Atlantis BG, Ltd.      | Ventsislav Genchev		|
| http://www.atlantis.bg | E-mail: vigour@atlantis.bg	|
=========================================================


--------------ms030101030307020103050202
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJSDCC
AwIwggJroAMCAQICAwm0SDANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNV
BAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUx
HTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVl
bWFpbCBSU0EgMjAwMC44LjMwMB4XDTAzMDQxMDEyNTI1NloXDTA0MDQwOTEyNTI1NlowRDEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEhMB8GCSqGSIb3DQEJARYSdmlnb3Vy
QGF0bGFudGlzLmJnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo6oeASU6WLte
jFKMzf1RVsoeWZhe4Qd4nTLLkg3KiMT4KA2lk07bK9y83rqoJfmo0sK//ZUZ9VRywIcAEsng
BJLwk/m5i2MHv9z196Dhk6tAZ7dm/Pnb0Ytd90qzRhVQGruIGa937jLjjwIlCE9wIgLyPw0a
4MLLVjT9ug2GCVZOLILGae2a3H15ifGu7OTlJ+x3EztOsS0sABwvnSgTK3jfJdeyGpCSSP7d
jiayUccOHt5DyoMErwkG7a0DqjjKQSIyHjP0v8+4m7b+wvMyLGeqmM35VbpmBhF3DkySBBHu
YQ/l0W86Uo7bfpkTiL7sS/CkQthAnh7Ov7sf/yBFDQIDAQABoy8wLTAdBgNVHREEFjAUgRJ2
aWdvdXJAYXRsYW50aXMuYmcwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQCk9Pug
/4YAMswaxQ0NYE0JfLGLbfXu66Pw+nJH6LvbJeyI2uyRO1f2RLnqCECL/hbCt29KgJ8vjXK2
8EjVHkAgCFZMLSTgiNKrSJz2fDf91x5WAlSuoUrxey2dtYgDVJcIMht4xKPgRWKvVWsxgxcP
P9IPdMMnzMj1aHyboz0OSzCCAwIwggJroAMCAQICAwm0SDANBgkqhkiG9w0BAQQFADCBkjEL
MAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3du
MQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYD
VQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwMB4XDTAzMDQxMDEyNTI1NloX
DTA0MDQwOTEyNTI1NlowRDEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEhMB8G
CSqGSIb3DQEJARYSdmlnb3VyQGF0bGFudGlzLmJnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAo6oeASU6WLtejFKMzf1RVsoeWZhe4Qd4nTLLkg3KiMT4KA2lk07bK9y83rqo
Jfmo0sK//ZUZ9VRywIcAEsngBJLwk/m5i2MHv9z196Dhk6tAZ7dm/Pnb0Ytd90qzRhVQGruI
Ga937jLjjwIlCE9wIgLyPw0a4MLLVjT9ug2GCVZOLILGae2a3H15ifGu7OTlJ+x3EztOsS0s
ABwvnSgTK3jfJdeyGpCSSP7djiayUccOHt5DyoMErwkG7a0DqjjKQSIyHjP0v8+4m7b+wvMy
LGeqmM35VbpmBhF3DkySBBHuYQ/l0W86Uo7bfpkTiL7sS/CkQthAnh7Ov7sf/yBFDQIDAQAB
oy8wLTAdBgNVHREEFjAUgRJ2aWdvdXJAYXRsYW50aXMuYmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQCk9Pug/4YAMswaxQ0NYE0JfLGLbfXu66Pw+nJH6LvbJeyI2uyRO1f2
RLnqCECL/hbCt29KgJ8vjXK28EjVHkAgCFZMLSTgiNKrSJz2fDf91x5WAlSuoUrxey2dtYgD
VJcIMht4xKPgRWKvVWsxgxcPP9IPdMMnzMj1aHyboz0OSzCCAzgwggKhoAMCAQICEGZFcrfM
dPXPY3ZFhNAukQEwDQYJKoZIhvcNAQEEBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxX
ZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1
bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNV
BAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29u
YWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMDA4MzAwMDAwMDBaFw0wNDA4MjcyMzU5NTla
MIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBl
IFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMx
KDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAwgZ8wDQYJKoZIhvcN
AQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7SbngnZ4HF2ogZgpcO40QpimM1Km1wPPrcrvfu
dG8wvDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWaNRqdknWoJ67Ycvm6AvbXsJHeHOmr
4BgDqHxDQlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr6aFpAgMBAAGjTjBMMCkGA1UdEQQi
MCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwxLTI5NzASBgNVHRMBAf8ECDAGAQH/AgEA
MAsGA1UdDwQEAwIBBjANBgkqhkiG9w0BAQQFAAOBgQAxsUtHXfkBceX1U2xdedY9mMAmE2KB
IqcS+CKV6BtJtyd7BDm6/ObyJOuR+r3sDSo491BVqGz3Da1MG7wD9LXrokefbKIMWI0xQgkR
bLAaadErErJAXWr5edDqLiXdiuT82w0fnQLzWtvKPPZE6iZph39Ins6ln+eE2MliYq0FxjGC
A9UwggPRAgEBMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIw
EAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNh
dGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAC
Awm0SDAJBgUrDgMCGgUAoIICDzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0wMzA5MDQxNjMyNTRaMCMGCSqGSIb3DQEJBDEWBBSK+4T0G+iRJqjsVtGfNhSJ
+er82zBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggq
hkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBqwYJKwYBBAGCNxAEMYGdMIGa
MIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBl
IFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMx
KDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwm0SDCBrQYLKoZI
hvcNAQkQAgsxgZ2ggZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUx
EjAQBgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZp
Y2F0ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4z
MAIDCbRIMA0GCSqGSIb3DQEBAQUABIIBACsEzxaq1l3NO5teB2Rp+CIXptw5fuEgJZ9iVhhk
UYp13+WlsyZ2m217zRWv1Su1a/GfjkDtw5Y57aisJntPEmsS7suN/0CsoURgq7d0SnFkLeTy
ENI38IpROKYsIU5Kk3DkJahlOWLfX7pGcJOQACadS+H7j8HdzFyoa+PStzArgLKEi3JbR299
5eZh9XprpEcXafgkj4flliYDuKlC7HEZ3aKQb5y7tEY8zO5OVzmha6M6cTE0slCkcJBqs5io
Bd18d9KiQ2GrgeLkPf7m1110MRuX+HH/d6mZqH7B7RFl3wgUW1wU5rKodMKbV/W2iHcsZ3v0
/FgRvFnigudcbFwAAAAAAAA=
--------------ms030101030307020103050202--

