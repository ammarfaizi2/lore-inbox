Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbVKOFpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVKOFpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 00:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVKOFpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 00:45:35 -0500
Received: from [202.125.80.34] ([202.125.80.34]:9359 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1751337AbVKOFpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 00:45:34 -0500
Content-class: urn:content-classes:message
Subject: FC4 Device permission Issues
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5E9A7.BA29AE92"
Date: Tue, 15 Nov 2005 11:12:09 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B13B7CA@mail.esn.co.in>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] [PATCH 00/13] Introduce task_pid api
Thread-Index: AcXppS59ue/llnVPStetvdhtyODPvAAAMQdg
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5E9A7.BA29AE92
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Dear Kernel Coders,

I have noticed my Flashmedia based block driver not working properly on =
FC4.=20
ISSUE is: I am not able to format the Block device file using any of the =
mkfs* commands.
Where as I am able to format the floopy drive.

But, I am able to mount, read/write & dd the device file.=20
Udev created the my flashmedia device file with following permission =
'640'.

I was also successfull in changing the device file permissions to '777' =
using the the "/etc/udev/rules.d/fm.rules"=20
file.

But Still I am not able to format the card and it says: permission =
denied.=20
But, at the same time I have no such issues with the same driver working =
on the FC3 dist.

I have noticed audit.log being updated with new error "denied" messages =
whenever I try to format the card.=20
Please see the attachment to this mail.

See the logs below as well:
# tail /var/log/audit/audit.log | grep tfa

type=3DPATH msg=3Daudit(1131719847.291:372708): item=3D0 =
name=3D"/dev/tfa3"
inode=3D9633 dev=3D00:0d mode=3D060666 ouid=3D0 ogid=3D0 rdev=3Dfc:18
type=3DAVC msg=3Daudit(1131719847.291:372708): avc: denied { read } for
pid=3D2849 comm=3D"mkfs.vfat" name=3Dtfa3 dev=3Dtmpfs ino=3D9633
scontext=3Droot:system_r:fsadm_t tcontext=3Dsystem_u:object_r:device_t
tclass=3Dblk_file

Regards,
Mukund Jampala


------_=_NextPart_001_01C5E9A7.BA29AE92
Content-Type: application/x-gzip;
	name="Linux_per_info[1].tar.gz"
Content-Transfer-Encoding: base64
Content-Description: Linux_per_info[1].tar.gz
Content-Disposition: attachment;
	filename="Linux_per_info[1].tar.gz"

H4sIABaudEMAA+1XbW+bMBDO1+ZXWOzLNkUJhEDaSHyY1uxF69qq2ctH5IBhXgAzbEfdpv33nR1C
0khLx5S2m+ZHItyZ83MX353BZ7SQ12FJqpAWCRt07gI2YOx5+g7YvWvZsV3Xc4Zj2xl24PKGfgd5
dxLNDiQXuEKoUzEm9tnd9vwfxdnN/AtMsxDLmIp+xtID+VAJ9kejX+bfc8br/PujsQv591zf6yD7
QP734j/Pv/hakuDy2btXKOdpoDP/2HFcZ+ycHI/G/eGJM3HH0JbHTyaICpIHNipwTgJrEJPlQCTY
tRAtWEyCE991EQwGtj2xY5SrMdu3fd9HTNIYJrJU3ypllEQT57irvT/78Pw3nONlNEHAX1ASI/Qd
VQTH6AdKGCSvBN7h8egERSzPAytfJLy/TLCwVrGqKHVkIi8TrsJdBcsjVghyLQKV2wn/yuH/hdUk
4TjOQ4HE+nH9RE7Y/DOJBJgAGY2Itskw58E8W4QJzUj3odPZGjv9PyOZGjisj1v633VH3s7+P3Js
0//3gtlUVwC01uuCCooz+o0Wab+7GZ/B+ggYg75BUCc55Zwuie7vLasrklLokkoZFkRAM4CCPjG2
4FtWz1leZqRmq91hQVlxwyER2kKWiFwDqZK5BNfzjEULvmXacMCW8Bh6En2KsdtDaleBqcJ90kOS
E46usRDVnml6X6jnaXk9UVS44FQFiGavT/keCr5qnIam0ddUKSkSHtZbyj6m/IskktQ0KwU4CiZg
dysSmsoKLNW2l+G5cpLuWw+ZEpHNm6ga/Y8Z4SrFmm6ltF8ssiSFKFmWNYFtjbResANkL5HgpCGp
tdaBlLQkDclKaULBfHFrCUF1b+pHK22mlxWL1r5BbB39HH7q+UpsPV9tkE34K6U1B7xpNyug5NYM
km+qXcutGWIyl2myKXGttV8NnG8WQ8kPUdZzeKfnIoQte10ZWyPt/1IZhTdKfDPQmgtLwRqelXKH
HA/9kv2LsfP99+Jtv5IZ4Qf1cdv5Dz73mvOfZ9fff675/rsPdB8NiIgGUp3mdOb78SDJ+0rqdh8l
OTrVRx3efTO9Op+eBYEFp6mnVu/o6OLj+fQqsNS6WD308uri/WWjvb04nQYWHP0s03sGBgYGBgYG
BgYGBgYGBgYGBgYGBg+Dn0kfvBcAKAAA

------_=_NextPart_001_01C5E9A7.BA29AE92--
