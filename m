Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTEHEja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 00:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbTEHEja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 00:39:30 -0400
Received: from mail007.syd.optusnet.com.au ([210.49.20.180]:50625 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261168AbTEHEj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 00:39:29 -0400
Date: Thu, 8 May 2003 14:54:12 +1000
From: Glenn McGrath <bug1@optushome.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] set argv[0] of init process to filename
Message-Id: <20030508145412.5d98ba5c.bug1@optushome.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="tbFmDciSA)=.uTM2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--tbFmDciSA)=.uTM2
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__8_May_2003_14:54:12_+1000_081a3070"


--Multipart_Thu__8_May_2003_14:54:12_+1000_081a3070
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


In init/main.c the kernel always sets argv[0] = "init" when calling the
init process.

The file being executed as init is commonly /sbin/init, but could be
anything, as set from init= boot paramater.

Always setting argv[0] = "init" is inconsistent with standard behaviour
of setting it to the filename that was run.

This current behaviour is inconvenient for busybox (www.busybox.net) as
it uses argv[0] to determine functionality.

The attached patch against 2.4.20 sets argv[0] to the filename being run
as the init process, it results in marginally smaller binary (12 bytes).

Is there a reason why argv[0] should always be set to "init" ?



Glenn 

--Multipart_Thu__8_May_2003_14:54:12_+1000_081a3070
Content-Type: application/octet-stream;
 name="init_argv.diff.gz"
Content-Disposition: attachment;
 filename="init_argv.diff.gz"
Content-Transfer-Encoding: base64

H4sICFjbuT4CA2luaXRfYXJndi5kaWZmAJVU207bShR9tr9iNy914kt8IUBBkegDOqXiIrWc6kgV
spzJBI9iz1gz4wSE+PezZxyTQIra+sHXfVlr7bUdhiFUjLcPYRodRGk8ZpzpcV0wHhEnjeM0jI/D
OIMkPsk+nRwcRnF/gJ/g2fV9/1WBqGacvq2ShfEEC0GSnBwcnSTHe1XOziBMkuPgEz7j5QjOzlxw
gXENUqxVAERU6hRfhaQsJIzoAyWtpjkRdV3w+akbuqHShWYEugAo5P0qNzB+Xn3+L7+4vrjNP3/7
57uf3sEUnmBgPg0CuP738jKA51PX/6v0Ls2cTW6fRPmqeZN0fv1j2/PLzdX5dIxdB7fn366mVrZd
DMh4g8IQz20paKRYsIrmiuq28bpOSsuh1SzNMhTLT7PkRTOHLcD7MMLidIhPjsQ8yVEhBzkpBBIj
2f4+waYOwu7unfEIDDJgCrAdaAEfLciPMHuEOV0UbaVhNMYcTh805pgupsS6RIjgeeYZX5uvQ/gw
tdSG8NRhnWRBkiHYSWKuBu17x8gUQGNZsMjBUkLSnNSN7RHY+U0HwWRoymOIY1v7U5gYqo7zxiEv
WH38th1ufLdDwjH8LziQQlG4vLi8MTrcC8bvjRIzITS0CtZMly9a9NUtJlsCbWCHRhvK5woGRavF
AGZ0ISQFXVJYlwKlIvXcAkbhSAl1saSqTzdBqqRVhXeML005VYq2msOGExSgiGSN7rCoFivwoqZR
X+G7gDUFds9NzwILIeG2plwrtKimks4h7xDlYHWMogh+Xn292xQYWwV37eK8MozjEME1GqOT7bkf
ESkpWXY+tfbrPDo5iIND8CfZcZCkG5PieKnksBJsbrUqEIqhoJqCUM+8Hpp16JfSxsmW26HluBGE
KuX98lcwdP2nzt+7I977X/jWICvqvfkSbDc/2O4zgvGfXf/Vepr3FikK3vJWUWxtrVgJssyXSI9W
HiZaCQ6Re4IaHKW9BnbS8nFjLkmJWFGJk5UUB/YIMymWlKMxCHrATtbuHQ7GCL3HOXTe47Ols8sm
7MMHYzVjfNz9DX8bSzX509C/qGpCVfleoG8Z787TbDxacs8Pr2JMIo5sP2qXsY36RcQLz/cCflth
w8m42GkKzog3uBbWM7AQLZ9HALfyEZpCKWMBu4UgGs0EN37o7BPZ/Gf3fxDHUO2lBwAA

--Multipart_Thu__8_May_2003_14:54:12_+1000_081a3070--

--tbFmDciSA)=.uTM2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ueL/WWZyfXiLlL8RAvszAJ9LuLcxMHqKWd9LHvG5r1+saanm1gCdHGFM
RSKFILkwqf59Yg0eYqGleOs=
=0ItS
-----END PGP SIGNATURE-----

--tbFmDciSA)=.uTM2--
