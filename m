Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWF1TPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWF1TPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWF1TPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:15:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52883 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751020AbWF1TPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:15:02 -0400
Subject: Re: [2.6 patch] typo fixes: aquire -> acquire
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060628165504.GX13915@stusta.de>
References: <20060628165504.GX13915@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 28 Jun 2006 16:14:43 -0300
Message-Id: <1151522083.3679.155.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2006-06-28 às 18:55 +0200, Adrian Bunk escreveu:
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Mauro Carvalho Chehab <mchehab@infradead.org>
> 
> ---
> 
>  Documentation/digiepca.txt                                   |    2 
>  Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    2 
>  drivers/char/isicom.c                                        |    4 -
>  drivers/media/video/bt8xx/bttvp.h                            |    2 
>  drivers/net/qla3xxx.c                                        |    2 
>  drivers/scsi/qla2xxx/qla_def.h                               |    2 
>  fs/befs/linuxvfs.c                                           |   38 +++++-----
>  fs/cifs/file.c                                               |    2 
>  fs/gfs2/recovery.c                                           |    2 
>  fs/jfs/jfs_txnmgr.c                                          |    2 
>  fs/reiser4/plugin/file/cryptcompress.c                       |    2 
>  sound/oss/dmabuf.c                                           |    6 -
>  12 files changed, 33 insertions(+), 33 deletions(-)
> 
> --- linux-2.6.17-mm3-full/Documentation/digiepca.txt.old	2006-06-27 20:39:06.000000000 +0200
> +++ linux-2.6.17-mm3-full/Documentation/digiepca.txt	2006-06-27 20:39:21.000000000 +0200
> @@ -2,7 +2,7 @@
>  http://www.digi.com for PCI cards.  They no longer maintain this driver,
>  and have no 2.6 driver for ISA cards.
>  
> -This driver requires a number of user-space tools.  They can be aquired from
> +This driver requires a number of user-space tools.  They can be acquired from
>  http://www.digi.com, but only works with 2.4 kernels.
>  
> 
> --- linux-2.6.17-mm3-full/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl.old	2006-06-27 20:39:29.000000000 +0200
> +++ linux-2.6.17-mm3-full/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl	2006-06-27 20:39:33.000000000 +0200
> @@ -3048,7 +3048,7 @@
>          </para>
>  
>          <para>
> -          If you aquire a spinlock in the interrupt handler, and the
> +          If you acquire a spinlock in the interrupt handler, and the
>          lock is used in other pcm callbacks, too, then you have to
>          release the lock before calling
>          <function>snd_pcm_period_elapsed()</function>, because
> --- linux-2.6.17-mm3-full/drivers/char/isicom.c.old	2006-06-27 20:39:40.000000000 +0200
> +++ linux-2.6.17-mm3-full/drivers/char/isicom.c	2006-06-27 20:39:46.000000000 +0200
> @@ -245,7 +245,7 @@
>  	printk(KERN_WARNING "ISICOM: Failed to lock Card (0x%lx)\n",
>  		card->base);
>  
> -	return 0;	/* Failed to aquire the card! */
> +	return 0;	/* Failed to acquire the card! */
>  }
>  
>  static int lock_card_at_interrupt(struct isi_board *card)
> @@ -262,7 +262,7 @@
>  			spin_unlock_irqrestore(&card->card_lock, card->flags);
>  	}
>  	/* Failing in interrupt is an acceptable event */
> -	return 0;	/* Failed to aquire the card! */
> +	return 0;	/* Failed to acquire the card! */
>  }
>  
>  static void unlock_card(struct isi_board *card)
> --- linux-2.6.17-mm3-full/drivers/media/video/bt8xx/bttvp.h.old	2006-06-27 20:39:55.000000000 +0200
> +++ linux-2.6.17-mm3-full/drivers/media/video/bt8xx/bttvp.h	2006-06-27 20:39:58.000000000 +0200
> @@ -360,7 +360,7 @@
>  	int mbox_csel;
>  
>  	/* risc memory management data
> -	   - must aquire s_lock before changing these
> +	   - must acquire s_lock before changing these
>  	   - only the irq handler is supported to touch top + bottom + vcurr */
>  	struct btcx_riscmem     main;
>  	struct bttv_buffer      *screen;    /* overlay             */
> --- linux-2.6.17-mm3-full/drivers/net/qla3xxx.c.old	2006-06-27 20:40:10.000000000 +0200
> +++ linux-2.6.17-mm3-full/drivers/net/qla3xxx.c	2006-06-27 20:40:14.000000000 +0200
> @@ -2953,7 +2953,7 @@
>  		ql_sem_unlock(qdev, QL_DRVR_SEM_MASK);
>  	} else {
>  		printk(KERN_ERR PFX
> -		       "%s: Could not aquire driver lock.\n",
> +		       "%s: Could not acquire driver lock.\n",
>  		       ndev->name);
>  		goto err_lock;
>  	}
> --- linux-2.6.17-mm3-full/drivers/scsi/qla2xxx/qla_def.h.old	2006-06-27 20:40:21.000000000 +0200
> +++ linux-2.6.17-mm3-full/drivers/scsi/qla2xxx/qla_def.h	2006-06-27 20:40:25.000000000 +0200
> @@ -2139,7 +2139,7 @@
>  	mempool_t	*srb_mempool;
>  
>  	/* This spinlock is used to protect "io transactions", you must
> -	 * aquire it before doing any IO to the card, eg with RD_REG*() and
> +	 * acquire it before doing any IO to the card, eg with RD_REG*() and
>  	 * WRT_REG*() for the duration of your entire commandtransaction.
>  	 *
>  	 * This spinlock is of lower priority than the io request lock.
> --- linux-2.6.17-mm3-full/fs/befs/linuxvfs.c.old	2006-06-27 20:40:33.000000000 +0200
> +++ linux-2.6.17-mm3-full/fs/befs/linuxvfs.c	2006-06-27 20:40:37.000000000 +0200
> @@ -325,7 +325,7 @@
>  	if (!bh) {
>  		befs_error(sb, "unable to read inode block - "
>  			   "inode = %lu", inode->i_ino);
> -		goto unaquire_none;
> +		goto unacquire_none;
>  	}
>  
>  	raw_inode = (befs_inode *) bh->b_data;
> @@ -334,7 +334,7 @@
>  
>  	if (befs_check_inode(sb, raw_inode, inode->i_ino) != BEFS_OK) {
>  		befs_error(sb, "Bad inode: %lu", inode->i_ino);
> -		goto unaquire_bh;
> +		goto unacquire_bh;
>  	}
>  
>  	inode->i_mode = (umode_t) fs32_to_cpu(sb, raw_inode->mode);
> @@ -402,17 +402,17 @@
>  		befs_error(sb, "Inode %lu is not a regular file, "
>  			   "directory or symlink. THAT IS WRONG! BeFS has no "
>  			   "on disk special files", inode->i_ino);
> -		goto unaquire_bh;
> +		goto unacquire_bh;
>  	}
>  
>  	brelse(bh);
>  	befs_debug(sb, "<--- befs_read_inode()");
>  	return;
>  
> -      unaquire_bh:
> +      unacquire_bh:
>  	brelse(bh);
>  
> -      unaquire_none:
> +      unacquire_none:
>  	make_bad_inode(inode);
>  	befs_debug(sb, "<--- befs_read_inode() - Bad inode");
>  	return;
> @@ -761,14 +761,14 @@
>  		printk(KERN_ERR
>  		       "BeFS(%s): Unable to allocate memory for private "
>  		       "portion of superblock. Bailing.\n", sb->s_id);
> -		goto unaquire_none;
> +		goto unacquire_none;
>  	}
>  	befs_sb = BEFS_SB(sb);
>  	memset(befs_sb, 0, sizeof(befs_sb_info));
>  
>  	if (!parse_options((char *) data, &befs_sb->mount_opts)) {
>  		befs_error(sb, "cannot parse mount options");
> -		goto unaquire_priv_sbp;
> +		goto unacquire_priv_sbp;
>  	}
>  
>  	befs_debug(sb, "---> befs_fill_super()");
> @@ -794,7 +794,7 @@
>  
>  	if (!(bh = sb_bread(sb, sb_block))) {
>  		befs_error(sb, "unable to read superblock");
> -		goto unaquire_priv_sbp;
> +		goto unacquire_priv_sbp;
>  	}
>  
>  	/* account for offset of super block on x86 */
> @@ -809,20 +809,20 @@
>  	}
>  
>  	if (befs_load_sb(sb, disk_sb) != BEFS_OK)
> -		goto unaquire_bh;
> +		goto unacquire_bh;
>  
>  	befs_dump_super_block(sb, disk_sb);
>  
>  	brelse(bh);
>  
>  	if (befs_check_sb(sb) != BEFS_OK)
> -		goto unaquire_priv_sbp;
> +		goto unacquire_priv_sbp;
>  
>  	if( befs_sb->num_blocks > ~((sector_t)0) ) {
>  		befs_error(sb, "blocks count: %Lu "
>  			"is larger than the host can use",
>  			befs_sb->num_blocks);
> -		goto unaquire_priv_sbp;
> +		goto unacquire_priv_sbp;
>  	}
>  
>  	/*
> @@ -838,7 +838,7 @@
>  	if (!sb->s_root) {
>  		iput(root);
>  		befs_error(sb, "get root inode failed");
> -		goto unaquire_priv_sbp;
> +		goto unacquire_priv_sbp;
>  	}
>  
>  	/* load nls library */
> @@ -860,13 +860,13 @@
>  
>  	return 0;
>  /*****************/
> -      unaquire_bh:
> +      unacquire_bh:
>  	brelse(bh);
>  
> -      unaquire_priv_sbp:
> +      unacquire_priv_sbp:
>  	kfree(sb->s_fs_info);
>  
> -      unaquire_none:
> +      unacquire_none:
>  	sb->s_fs_info = NULL;
>  	return -EINVAL;
>  }
> @@ -925,18 +925,18 @@
>  
>  	err = befs_init_inodecache();
>  	if (err)
> -		goto unaquire_none;
> +		goto unacquire_none;
>  
>  	err = register_filesystem(&befs_fs_type);
>  	if (err)
> -		goto unaquire_inodecache;
> +		goto unacquire_inodecache;
>  
>  	return 0;
>  
> -unaquire_inodecache:
> +unacquire_inodecache:
>  	befs_destroy_inodecache();
>  
> -unaquire_none:
> +unacquire_none:
>  	return err;
>  }
>  
> --- linux-2.6.17-mm3-full/fs/cifs/file.c.old	2006-06-27 20:40:46.000000000 +0200
> +++ linux-2.6.17-mm3-full/fs/cifs/file.c	2006-06-27 20:40:49.000000000 +0200
> @@ -324,7 +324,7 @@
>  	return rc;
>  }
>  
> -/* Try to reaquire byte range locks that were released when session */
> +/* Try to reacquire byte range locks that were released when session */
>  /* to server was lost */
>  static int cifs_relock_file(struct cifsFileInfo *cifsFile)
>  {
> --- linux-2.6.17-mm3-full/fs/jfs/jfs_txnmgr.c.old	2006-06-27 20:40:57.000000000 +0200
> +++ linux-2.6.17-mm3-full/fs/jfs/jfs_txnmgr.c	2006-06-27 20:41:00.000000000 +0200
> @@ -842,7 +842,7 @@
>  	TXN_UNLOCK();
>  	release_metapage(mp);
>  	TXN_LOCK();
> -	xtid = tlck->tid;	/* reaquire after dropping TXN_LOCK */
> +	xtid = tlck->tid;	/* reacquire after dropping TXN_LOCK */
>  
>  	jfs_info("txLock: in waitLock, tid = %d, xtid = %d, lid = %d",
>  		 tid, xtid, lid);
> --- linux-2.6.17-mm3-full/fs/gfs2/recovery.c.old	2006-06-27 20:41:07.000000000 +0200
> +++ linux-2.6.17-mm3-full/fs/gfs2/recovery.c	2006-06-27 20:41:29.000000000 +0200
> @@ -438,7 +438,7 @@
>  		fs_info(sdp, "jid=%u: Trying to acquire journal lock...\n",
>  			jd->jd_jid);
>  
> -		/* Aquire the journal lock so we can do recovery */
> +		/* Acquire the journal lock so we can do recovery */
>  
>  		error = gfs2_glock_nq_num(sdp, jd->jd_jid, &gfs2_journal_glops,
>  					  LM_ST_EXCLUSIVE,
> --- linux-2.6.17-mm3-full/fs/reiser4/plugin/file/cryptcompress.c.old	2006-06-27 20:41:36.000000000 +0200
> +++ linux-2.6.17-mm3-full/fs/reiser4/plugin/file/cryptcompress.c	2006-06-27 20:41:48.000000000 +0200
> @@ -3112,7 +3112,7 @@
>  	return result;
>  }
>  
> -/* Append or expand hole in two steps (exclusive access should be aquired!)
> +/* Append or expand hole in two steps (exclusive access should be acquired!)
>     1) write zeroes to the current real cluster,
>     2) expand hole via fake clusters (just increase i_size) */
>  static int
> --- linux-2.6.17-mm3-full/sound/oss/dmabuf.c.old	2006-06-27 20:42:01.000000000 +0200
> +++ linux-2.6.17-mm3-full/sound/oss/dmabuf.c	2006-06-27 20:42:08.000000000 +0200
> @@ -547,7 +547,7 @@
>  	}
>  	return 0;
>  }
> -/* aquires lock */
> +/* acquires lock */
>  int DMAbuf_getrdbuffer(int dev, char **buf, int *len, int dontblock)
>  {
>  	struct audio_operations *adev = audio_devs[dev];
> @@ -821,7 +821,7 @@
>  	*size = len & ~SAMPLE_ROUNDUP;
>  	return (*size > 0);
>  }
> -/* aquires lock  */
> +/* acquires lock  */
>  int DMAbuf_getwrbuffer(int dev, char **buf, int *size, int dontblock)
>  {
>  	struct audio_operations *adev = audio_devs[dev];
> @@ -855,7 +855,7 @@
>  	spin_unlock_irqrestore(&dmap->lock,flags);
>  	return 0;
>  }
> -/* has to aquire dmap->lock */
> +/* has to acquire dmap->lock */
>  int DMAbuf_move_wrpointer(int dev, int l)
>  {
>  	struct audio_operations *adev = audio_devs[dev];
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Cheers, 
Mauro.

