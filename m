Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbREVPze>; Tue, 22 May 2001 11:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261966AbREVPzY>; Tue, 22 May 2001 11:55:24 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:38151 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S261921AbREVPzP>;
	Tue, 22 May 2001 11:55:15 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jan Harkes <jaharkes@cs.cmu.edu>
Date: Tue, 22 May 2001 17:52:53 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partio
CC: viro@math.psu.edu, rgooch@ras.ucalgary.ca, matthew@wil.cx, clausen@gnu.org,
        bcrl@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@transmeta.com
X-mailer: Pegasus Mail v3.40
Message-ID: <3A5DF9F50CC@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[trimmed cc list down a bit - my MUA does not allow for so long CC:]

On 22 May 01 at 9:33, Jan Harkes wrote:
> 
> something like,
> 
>     ssize_t kioctl(int fd, int type, int cmd, void *inbuf, size_t inlen,
>            void *outbuf, size_t outlen);

If we are inventing new API, then if we could have

      ssize_t kioctl(int fd, int type, int cmd, 
              const struct iovec* riov, size_t riov_len,
              const struct iovec* wiov, size_t wiov_len);
              
then I'm almost sure that it will save couple of passing pointer to pointer
in structure headaches - for sure it will in code I maintain (ncpfs).
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
