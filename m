Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267687AbTGLQPN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbTGLQNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:13:09 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:30884 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266169AbTGLQMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:12:51 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Sat, 12 Jul 2003 18:27:09 +0200
User-Agent: KMail/1.5.2
References: <200307112053.55880.kernel@kolivas.org> <200307121013.14347.kernel@kolivas.org> <200307130139.45477.kernel@kolivas.org>
In-Reply-To: <200307130139.45477.kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       smiler@lanil.mine.nu, phillips@arcor.de
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307121826.24645.fsdeveloper@yahoo.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 12 July 2003 17:39, Con Kolivas wrote:
[SNIP]
> @@ -2153,6 +2208,9 @@ asmlinkage long sys_sched_get_priority_m
>  	case SCHED_NORMAL:
>  		ret = 0;
>  		break;
> +	case SCHED_ISO:
> +		ret = 0;
> +		break;
>  	}
>  	return ret;
>  }
> @@ -2175,6 +2233,8 @@ asmlinkage long sys_sched_get_priority_m
>  		break;
>  	case SCHED_NORMAL:
>  		ret = 0;
> +	case SCHED_ISO:
> +		ret = 0;
>  	}
>  	return ret;
>  }

As far, as I can see, this would do the very same
things, with reduced codesize:

 	case SCHED_NORMAL:
+	case SCHED_ISO:
 		ret = 0;
 		break;
 	}
 	return ret;
 }


and this:

 		break;
 	case SCHED_NORMAL:
+	case SCHED_ISO:
 		ret = 0;
 	}
 	return ret;
 }


- --
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 18:22:51 up 49 min,  2 users,  load average: 2.14, 2.32, 2.31

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/EDbdoxoigfggmSgRAgFpAJ9Iz71qcgIFEM8mYIY9Xrw9Yn5BfQCeLZf3
5h47aU7gAzFYYrdLVS0RVZ8=
=drFI
-----END PGP SIGNATURE-----

