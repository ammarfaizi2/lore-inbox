Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVDDX6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVDDX6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVDDX6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:58:22 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:27533 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S261504AbVDDXzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:55:02 -0400
Message-ID: <4251D3CB.4010501@kroon.co.za>
Date: Tue, 05 Apr 2005 01:54:51 +0200
From: Jaco Kroon <jaco@kroon.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050328
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, Sebastian Piechocki <sebekpi@poczta.onet.pl>
Subject: Re: i8042 controller on Toshiba Satellite P10 notebook - patch
References: <425166F9.1040800@kroon.co.za>	 <d120d5000504040954354fb3fa@mail.gmail.com>	 <42517442.20602@kroon.co.za>	 <d120d500050404110374fe9deb@mail.gmail.com>	 <4251A515.8040802@kroon.co.za>	 <d120d500050404140253a77ab8@mail.gmail.com>	 <4251B6E2.3010506@kroon.co.za> <d120d50005040415506cd87287@mail.gmail.com>
In-Reply-To: <d120d50005040415506cd87287@mail.gmail.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080303030406010206060306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080303030406010206060306
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dmitry Torokhov wrote:
> Ok, try booting with "usb-handoff i8042.nomux". If that cures

yes, it cures both problems (death on reboot and ALPS), in fact.  But I
must have *both* params.  nomux without usb-handoff causes all input
devices to fail.  Thanks goodness for ssh.  Anyway - I'm now running a
clean 2.6.11.6 kernel that *works*.

> death-on-reboot problem then Vojtech already has a patch in
> 2.6.12-rc1:
> 
> http://linux.bkbits.net:8080/linux-2.5/cset@41f8e2d7j4JtjbrlrI5eYgQQ86yDhg

Yes, this should fix the death-on-reboot (why oh why can't the BIOS just
"do the right thing"), it still won't get me alps though.  For that I
need the nomux option - ie, a total different codepath than what that
patch attends to.  And it probably won't fix the keyboard problem.  This
sucks (don't get me wrong - I appreciate that my hardware is now
functioning properly - only things afaik that doesn't work now is the SD
card reader and suspend/hibernate and with ati-drivers there is not a
chance in hell that that'll ever work, neither of which is of critical
importance for me).

> Yes, with 4 ports your external mouse is independent from the touhpad.
> When you have only 1 port you can't use touchpad's extended mode
> together with an external mouse.

No external PS/2 port :).

>>With my patch I do get the ALPS support though - something which I
>>didn't get with usb-handoff, nor with acpi=off, nor with simply hacking
>>out the AUX_LOOP and AUX_TEST tests and just assuming the hardware is
>>there (I saw ALPS yesterday for the first time in my life for that matter).
> 
> Hmm, I'd like to debug that once we resolve reboot problems.

Anything else that you would like me to try?

>>OT:  I think I prefer synaptics multi-finger tapping to the tapping in
>>specific locations to get right and middle clicking, but that is another
>>story that probably has nothing to do with the kernel, and quite likely
>>something that is configurable in the synaptics xorg driver.
> 
> You should be able to control that in xorg.conf.

My thoughts exactly.  The same goes for gpm.

Thanks a lot for your time, patience and knowledge.

Jaco
-- 
There are only 10 kinds of people in this world,
  those that understand binary and those that don't.
http://www.kroon.co.za/

--------------ms080303030406010206060306
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII5TCC
As0wggI2oAMCAQICAw3p1jANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwMTI4MjExMjIzWhcNMDYwMTI4MjExMjIz
WjBCMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMR8wHQYJKoZIhvcNAQkBFhBq
YWNvQGtyb29uLmNvLnphMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4CsLuOWD
wimwAv4QLdlT99frJCwzUBVQNL7c7x4ufEquAH6RamWfQyQHzykEJM8NeMIrfb+k3fZEi+ZU
g5sq2uIqzOuCJsIj0x3LnoydXTikbv1AFWQDEuqITlroA8bGJE/mMlbPrKyDACPo5cQAzUQz
LAg7LQQQVkKNWH4eeXUwZ5lOZEWWno0P5DXHdSLQxCshgWVPRrbtKe25WGObqJMa//1T5qX8
0mKIdAbHlz90BwgX/MjLp0BpXTii2653ScOujCLTC3cPdDUDK68qG7RqatVw5+HE/npJIWa1
0TxJUp5Ii8nPbGPzpEWQmZ8TjkjMs26w80PPPKh2Vh2siQIDAQABoy0wKzAbBgNVHREEFDAS
gRBqYWNvQGtyb29uLmNvLnphMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAqXNX
QEMTVQoj3JoEwK9vlfqSVz5ZEUklpgEhwFJsD+PKa/LgUGVHk3Gw8wws4+wZxmpOsJ7vdiWL
y8zlX7HfPWMcbibTi6C7nT6WahqdeAo3kVjhnMqJ3Sf6sX0JGl9bWfIhgmIVy/ZdM2ztrXwd
rbWiT7un5lM05D4YPCNH9fcwggLNMIICNqADAgECAgMN6dYwDQYJKoZIhvcNAQEEBQAwYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA1MDEyODIx
MTIyM1oXDTA2MDEyODIxMTIyM1owQjEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJl
cjEfMB0GCSqGSIb3DQEJARYQamFjb0Brcm9vbi5jby56YTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAOArC7jlg8IpsAL+EC3ZU/fX6yQsM1AVUDS+3O8eLnxKrgB+kWpln0Mk
B88pBCTPDXjCK32/pN32RIvmVIObKtriKszrgibCI9Mdy56MnV04pG79QBVkAxLqiE5a6APG
xiRP5jJWz6ysgwAj6OXEAM1EMywIOy0EEFZCjVh+Hnl1MGeZTmRFlp6ND+Q1x3Ui0MQrIYFl
T0a27SntuVhjm6iTGv/9U+al/NJiiHQGx5c/dAcIF/zIy6dAaV04otuud0nDrowi0wt3D3Q1
AyuvKhu0amrVcOfhxP56SSFmtdE8SVKeSIvJz2xj86RFkJmfE45IzLNusPNDzzyodlYdrIkC
AwEAAaMtMCswGwYDVR0RBBQwEoEQamFjb0Brcm9vbi5jby56YTAMBgNVHRMBAf8EAjAAMA0G
CSqGSIb3DQEBBAUAA4GBAKlzV0BDE1UKI9yaBMCvb5X6klc+WRFJJaYBIcBSbA/jymvy4FBl
R5NxsPMMLOPsGcZqTrCe73Yli8vM5V+x3z1jHG4m04ugu50+lmoanXgKN5FY4ZzKid0n+rF9
CRpfW1nyIYJiFcv2XTNs7a18Ha21ok+7p+ZTNOQ+GDwjR/X3MIIDPzCCAqigAwIBAgIBDTAN
BgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTES
MBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UE
CxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0
aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMC
WkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GN
ADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAK
MNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYB
Af8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBl
cnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYD
VQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2as
Zw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSe
JVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHT
HUb/XV9lTzGCAzswggM3AgEBMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAgMN6dYwCQYFKw4DAhoFAKCCAacwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMDUwNDA0MjM1NDUxWjAjBgkqhkiG9w0BCQQxFgQUnhk2
6NilY6RcdEOqfGttu+ERAKcwUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG
9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgweAYJKwYB
BAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcg
KFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vpbmcg
Q0ECAw3p1jB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMN6dYwDQYJKoZIhvcNAQEBBQAEggEAHMJX6+co1DqVJb08
4ZC71KcueCoBRKCbvdpqXnSIrtKftod8+BQGGGQkX9tCgBBIVjJVu3YnFyCK1mFbpmVRRv7L
24+IbrL+tMy6UaP8BVSjRJ38hnIzgDliU9fz+7YjdrSC77nMk4Po33RgTBc25WhmaevNUGxA
VzqQYLcO4gabAMOGXj6ZwCZdiAPV3WQv8v+2KB5N8FMaJEuNwDtMz6IxXpB/SvtMDlrgMs65
6BoxZSCFZNe6SSdhEQCxGMRD/YQmeuMQz8PUUf3UhmFt8WilrYhXVw4wCOuGWCMgLNDGI5B/
xjIS78deM58q7HtJ/oxpkUVvJ9qsIdtBhS0A2QAAAAAAAA==
--------------ms080303030406010206060306--
