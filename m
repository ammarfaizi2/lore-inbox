Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRB0JpT>; Tue, 27 Feb 2001 04:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129635AbRB0JpD>; Tue, 27 Feb 2001 04:45:03 -0500
Received: from v25.hebdomag.com ([207.253.212.25]:45577 "EHLO trader-tcp.com")
	by vger.kernel.org with ESMTP id <S129631AbRB0Jol>;
	Tue, 27 Feb 2001 04:44:41 -0500
Message-ID: <3A9B7836.48C21224@trader.com>
Date: Tue, 27 Feb 2001 10:49:42 +0100
From: Joseph Bueno <joseph.bueno@trader.com>
X-Mailer: Mozilla 4.73 [fr] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rsaura@retevision.es
CC: linux-kernel@vger.kernel.org
Subject: Re: increasing the number of file descriptors
In-Reply-To: <OFA7D9F891.904FF16B-ONC1256A00.0031BFB0@retevision.es>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rsaura@retevision.es a écrit :
> 
>       I've recently hit a problem with a httpd process running out of space
>       for more fd.
> 
>       While I'm seriouly looking for a fd-leak in the php-development
>       behind the web server, I realized that i didn't know how to increase
>       this parameter.
> 
>       Is there any /proc interface for increasing the number of file
>       descriptors per process?
> 
>       Must I recompile? maybe changes must be made to files_struct?
> 
>       I've seen a patch for "variable fd array patch for 2.1.90" from Bill
>       Hawes, is there a patch for 2.2.x or 2.4.x kernels?
> 
>       Please CC answers to rsaura@retevision.es
> 
>       TAI.
> 
>           Raúl Saura.
> 
> La información incluida en el presente correo electrónico es CONFIDENCIAL,
> siendo para el uso exclusivo del destinatario arriba mencionado. Si usted
> lee este mensaje y no es el destinatario señalado, el empleado o el agente
> responsable de entregar el mensaje al destinatario, o ha recibido esta
> comunicación por error, le informamos que está totalmente prohibida
> cualquier divulgación, distribución o reproducción de esta comunicación, y
> le rogamos que nos lo notifique, nos devuelva el mensaje original a la
> dirección arriba mencionada y borre el mensaje.
> Gracias.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Hi,

You can change per process file descriptor limit with ulimit.

If your processes are using a lot of fds you can increase system wide limits
with:
/proc/sys/fs/file-max
/proc/sys/fs/inode-max

Regards
--
Joseph Bueno
NetClub/Trader.com
